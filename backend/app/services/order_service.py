from sqlalchemy.orm import Session
from datetime import datetime
from fastapi import HTTPException, status
from typing import List
from ..models.tables import Order, OrderDish, Dish, User
from ..schemas import order_schema

class OrderService:
    @staticmethod
    def calculate_total_amount(db: Session, dishes: List[order_schema.OrderDishBase]) -> float:
        """Calculate total amount for order"""
        total = 0.0
        for order_dish in dishes:
            dish = db.query(Dish).filter(
                Dish.dish_id == order_dish.dish_id
            ).first()
            if not dish:
                raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f"Dish {order_dish.dish_id} not found")
            total += dish.price * order_dish.quantity
        return total

    @staticmethod
    def create_order(db: Session, order_data: order_schema.OrderCreate) -> Order:
        """Create a new order"""
        # Tạo order
        db_order = Order(
            user_id=order_data.user_id,
            order_type=order_data.order_type,
            booking_id=order_data.booking_id,
            status=0,  # Chờ xử lý
            delivery_address=order_data.delivery_address if order_data.order_type == 1 else None,
            total_amount=OrderService.calculate_total_amount(db, order_data.dishes)
        )
        db.add(db_order)

        # Thêm các món ăn vào order
        for dish_item in order_data.dishes:
            order_dish = OrderDish(
                order_id=db_order.order_id,
                dish_id=dish_item.dish_id,
                quantity=dish_item.quantity
            )
            db.add(order_dish)

        db.commit()
        db.refresh(db_order)
        return db_order

    @staticmethod
    def get_order(db: Session, order_id: int) -> Order:
        """Get order by ID"""
        order = db.query(Order).filter(Order.order_id == order_id).first()
        if not order:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Không tìm thấy đơn hàng"
            )
        return order

    @staticmethod
    def get_user_orders(db: Session, user_id: int, skip: int = 0, limit: int = 100) -> List[Order]:
        """Get all orders for a user with pagination"""
        return db.query(Order).filter(
            Order.user_id == user_id
        ).offset(skip).limit(limit).all()

    @staticmethod
    def get_booking_orders(db: Session, booking_id: int) -> List[Order]:
        """Get all orders for a booking"""
        return db.query(Order).filter(Order.booking_id == booking_id).all()

    @staticmethod
    def update_order_status(db: Session, order_id: int, new_status: int) -> Order:
        """Update order status"""
        order = OrderService.get_order(db, order_id)
        if order.status == 4:  # Đã hủy
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Không thể cập nhật trạng thái của đơn hàng đã hủy"
            )
        if new_status < order.status and order.status != 0:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Không thể cập nhật trạng thái đơn hàng về trạng thái trước đó"
            )
        order.status = new_status
        db.commit()
        db.refresh(order)
        return order
