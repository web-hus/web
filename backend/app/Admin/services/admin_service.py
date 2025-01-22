from datetime import datetime
from fastapi import HTTPException, status
from sqlalchemy.orm import Session
from typing import List, Optional
from ...core.security import get_password

from ...models.tables import User, Order, Booking, Dish, OrderDish, ShoppingCart
from ..schemas import admin_schema

class AdminService:
    @staticmethod
    def create_user(db: Session, user_data: admin_schema.UserCreate) -> User:
        """Create new user by admin"""
        if db.query(User).filter(User.email == user_data.email).first():
            raise HTTPException(status_code=400, detail="Email already registered")
        
        if db.query(User).filter(User.phone == user_data.phone).first():
            raise HTTPException(status_code=400, detail="Phone number already registered")

        db_user = User(
            user_name=user_data.user_name,
            age=user_data.age,
            gender=user_data.gender,
            address=user_data.address,
            email=user_data.email,
            phone=user_data.phone,
            password=get_password(user_data.password),
            role=user_data.role,
            created_at=datetime.utcnow(),
            updated_at=datetime.utcnow()
        )
        db.add(db_user)
        db.commit()
        db.refresh(db_user)
        return db_user

    @staticmethod
    def get_all_users(db: Session, skip: int = 0, limit: int = 100) -> List[User]:
        """Get all users"""
        return db.query(User).offset(skip).limit(limit).all()

    @staticmethod
    def get_user(db: Session, user_id: int) -> Optional[User]:
        """Get user by ID"""
        return db.query(User).filter(User.user_id == user_id).first()
    
    @staticmethod
    def get_cart(db:Session, user_id: int):
        return db.query(ShoppingCart).filter(ShoppingCart.user_id == user_id).first()

    @staticmethod
    def update_user(db: Session, user_id: int, user_data: admin_schema.UserUpdate, current_admin_id: int) -> User:
        """Update user"""
        # Lấy thông tin user cần update
        db_user = AdminService.get_user(db, user_id)
        if not db_user:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Không tìm thấy user"
            )

        # Kiểm tra quyền
        # 1. Nếu user cần update là admin (role=1)
        if db_user.role == 1:
            # Admin chỉ có thể tự sửa thông tin của mình
            if db_user.user_id != current_admin_id:
                raise HTTPException(
                    status_code=status.HTTP_403_FORBIDDEN,
                    detail="Không có quyền sửa thông tin của admin khác"
                )

        update_data = user_data.dict(exclude_unset=True)

        # Kiểm tra email trùng
        if "email" in update_data and update_data["email"] != db_user.email:
            if db.query(User).filter(User.email == update_data["email"]).first():
                raise HTTPException(
                    status_code=status.HTTP_400_BAD_REQUEST,
                    detail="Email đã tồn tại"
                )

        # Kiểm tra số điện thoại trùng
        if "phone" in update_data and update_data["phone"] != db_user.phone:
            if db.query(User).filter(User.phone == update_data["phone"]).first():
                raise HTTPException(
                    status_code=status.HTTP_400_BAD_REQUEST,
                    detail="Số điện thoại đã tồn tại"
                )

        # Xử lý password nếu có
        if "password" in update_data:
            update_data["password"] = get_password(update_data["password"])

        for key, value in update_data.items():
            setattr(db_user, key, value)

        db_user.updated_at = datetime.utcnow()
        db.commit()
        db.refresh(db_user)
        return db_user

    @staticmethod
    def delete_user(db: Session, user_id: int, current_admin_id: int) -> User:
        """Delete user"""
        db_user = AdminService.get_user(db, user_id)
        db_user_cart = AdminService.get_cart(db,user_id)
        if not db_user:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Không tìm thấy user"
            )

        # Kiểm tra quyền
        # 1. Không thể xóa tài khoản admin
        if db_user.role == 1:
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="Không thể xóa tài khoản admin"
            )

        db.delete(db_user)
        db.delete(db_user_cart)
        db.commit()
        return db_user

    @staticmethod
    def create_dine_in_order(db: Session, order_data: admin_schema.DineInOrderCreate) -> Order:
        """Create dine-in order"""
        # Tìm user_id nếu không được cung cấp
        user_id = order_data.user_id
        if not user_id:
            if order_data.phone:
                user = db.query(User).filter(User.phone == order_data.phone).first()
            elif order_data.email:
                user = db.query(User).filter(User.email == order_data.email).first()
            else:
                raise HTTPException(
                    status_code=status.HTTP_400_BAD_REQUEST,
                    detail="Phải cung cấp user_id, phone hoặc email"
                )
            
            if not user:
                raise HTTPException(
                    status_code=status.HTTP_404_NOT_FOUND,
                    detail="Không tìm thấy user"
                )
            user_id = user.user_id

        # Kiểm tra booking nếu có
        if order_data.booking_id:
            booking = db.query(Booking).filter(
                Booking.booking_id == order_data.booking_id
            ).first()
            if not booking:
                raise HTTPException(
                    status_code=status.HTTP_404_NOT_FOUND,
                    detail="Không tìm thấy đặt chỗ"
                )

        # Tính tổng tiền
        total_amount = 0
        for dish in order_data.dishes:
            dish_record = db.query(Dish).filter(Dish.dish_id == dish["dish_id"]).first()
            if not dish_record:
                raise HTTPException(
                    status_code=status.HTTP_404_NOT_FOUND,
                    detail=f"Không tìm thấy món ăn {dish['dish_id']}"
                )
            total_amount += dish_record.price * dish["quantity"]

        # Tạo order
        db_order = Order(
            user_id=user_id,
            booking_id=order_data.booking_id,
            total_amount=total_amount,
            status=1,  # Pending
            order_type="dine-in",
            created_at=datetime.utcnow(),
            updated_at=datetime.utcnow()
        )
        db.add(db_order)
        db.flush()

        # Thêm chi tiết món ăn
        for dish in order_data.dishes:
            order_dish = OrderDish(
                order_id=db_order.order_id,
                dish_id=dish["dish_id"],
                quantity=dish["quantity"]
            )
            db.add(order_dish)

        db.commit()
        db.refresh(db_order)
        return db_order

    @staticmethod
    def update_booking_status(db: Session, booking_id: int, status: int) -> Booking:
        """Update booking status"""
        booking = db.query(Booking).filter(Booking.booking_id == booking_id).first()
        if not booking:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Không tìm thấy đặt chỗ"
            )

        if status not in [1, 2]:  # 1: Confirmed, 2: Cancelled
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Trạng thái không hợp lệ"
            )

        booking.status = status
        booking.updated_at = datetime.utcnow()
        db.commit()
        db.refresh(booking)
        return booking

    @staticmethod
    def update_order_status(db: Session, order_id: int, status: int) -> Order:
        """Update order status"""
        order = db.query(Order).filter(Order.order_id == order_id).first()
        if not order:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Không tìm thấy đơn hàng"
            )

        if status not in [1, 2, 3, 4]:  # 1: Pending, 2: Confirmed, 3: Completed, 4: Cancelled
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Trạng thái không hợp lệ"
            )

        order.status = status
        order.updated_at = datetime.utcnow()
        db.commit()
        db.refresh(order)
        return order
    @staticmethod
    def get_all_users(db: Session):
        return db.query(User).all()

    @staticmethod
    def get_all_bookings(db: Session):
        return db.query(Booking).all()

    @staticmethod
    def get_all_orders(db: Session):
        return db.query(Order).all()
