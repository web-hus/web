from sqlalchemy.orm import Session
from datetime import datetime
from ...models import user_model, order_model, booking_model
from ..schemas import admin_schema
from fastapi import HTTPException
from ...services.order_service import OrderService
from ...core.security import get_password_hash

class AdminService:
    @staticmethod
    def create_user(db: Session, user_data: admin_schema.UserCreate):
        """Create new user by admin"""
        if db.query(user_model.User).filter(user_model.User.email == user_data.email).first():
            raise HTTPException(status_code=400, detail="Email already registered")
        
        if db.query(user_model.User).filter(user_model.User.phone == user_data.phone).first():
            raise HTTPException(status_code=400, detail="Phone number already registered")

        db_user = user_model.User(
            user_name=user_data.user_name,
            age=user_data.age,
            gender=user_data.gender,
            address=user_data.address,
            email=user_data.email,
            phone=user_data.phone,
            password=get_password_hash(user_data.password),
            role=user_data.role,
            created_at=datetime.utcnow(),
            updated_at=datetime.utcnow()
        )
        db.add(db_user)
        db.commit()
        db.refresh(db_user)
        return db_user

    @staticmethod
    def create_dine_in_order(db: Session, order_data: admin_schema.DineInOrderCreate):
        """Create dine-in order for walk-in customers or booked customers"""
        user_id = order_data.user_id
        if not user_id:
            if order_data.phone:
                user = db.query(user_model.User).filter(
                    user_model.User.phone == order_data.phone
                ).first()
            elif order_data.email:
                user = db.query(user_model.User).filter(
                    user_model.User.email == order_data.email
                ).first()
            else:
                raise HTTPException(status_code=400, detail="Must provide user_id, phone or email")
            
            if not user:
                raise HTTPException(status_code=404, detail="User not found")
            user_id = user.user_id

        if order_data.booking_id:
            booking = db.query(booking_model.Booking).filter(
                booking_model.Booking.booking_id == order_data.booking_id,
                booking_model.Booking.user_id == user_id,
                booking_model.Booking.status == 1  
            ).first()
            if not booking:
                raise HTTPException(status_code=404, detail="Valid booking not found")

        total_amount = 0
        for dish in order_data.dishes:
            dish_record = db.query(dish_model.Dish).filter(
                dish_model.Dish.dish_id == dish["dish_id"]
            ).first()
            if not dish_record:
                raise HTTPException(status_code=404, detail=f"Dish {dish['dish_id']} not found")
            total_amount += dish_record.price * dish["quantity"]

        new_order = order_model.Order(
            user_id=user_id,
            order_type=0,  
            booking_id=order_data.booking_id,
            order_date=datetime.utcnow(),
            total_amount=total_amount,
            created_at=datetime.utcnow(),
            updated_at=datetime.utcnow()
        )
        db.add(new_order)
        db.flush()

        for dish in order_data.dishes:
            order_dish = order_model.OrderDish(
                order_id=new_order.order_id,
                dish_id=dish["dish_id"],
                quantity=dish["quantity"]
            )
            db.add(order_dish)

        db.commit()
        db.refresh(new_order)
        return new_order

    @staticmethod
    def update_booking_status(db: Session, booking_id: int, status: int):
        """Update booking status"""
        booking = db.query(booking_model.Booking).filter(
            booking_model.Booking.booking_id == booking_id
        ).first()
        if not booking:
            raise HTTPException(status_code=404, detail="Đặt bàn không tồn tại")

        if status not in [1, 2]: 
            raise HTTPException(status_code=400, detail="Trạng thái không hợp lệ")

        booking.status = status
        booking.updated_at = datetime.utcnow()
        db.commit()
        db.refresh(booking)
        return booking

    @staticmethod
    def update_order_status(db: Session, order_id: int, status: int):
        """Update order status for takeaway orders"""
        order = db.query(order_model.Order).filter(
            order_model.Order.order_id == order_id,
            order_model.Order.order_type == 1  
        ).first()
        if not order:
            raise HTTPException(status_code=404, detail="Đơn mang về không được tìm thấy")

        if status not in [1, 2, 3, 4]: 
            raise HTTPException(status_code=400, detail="Trạng thái không hợp lệ")

        order.status = status
        order.updated_at = datetime.utcnow()
        db.commit()
        db.refresh(order)
        return order
