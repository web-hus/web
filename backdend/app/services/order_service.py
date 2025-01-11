from sqlalchemy.orm import Session
from datetime import datetime
from ..models import order_model, user_model, dish_model
from ..schemas import order_schema
from fastapi import HTTPException
from typing import List

class OrderService:
    @staticmethod
    def calculate_total_amount(db: Session, dishes: List[order_schema.OrderDishBase]) -> float:
        """Calculate total amount for order"""
        total = 0.0
        for order_dish in dishes:
            dish = db.query(dish_model.Dish).filter(
                dish_model.Dish.dish_id == order_dish.dish_id
            ).first()
            if not dish:
                raise HTTPException(status_code=404, detail=f"Dish {order_dish.dish_id} not found")
            total += dish.price * order_dish.quantity
        return total

    @staticmethod
    def create_order_dishes(db: Session, order_id: int, dishes: List[order_schema.OrderDishBase]):
        """Create order dishes records"""
        for dish_item in dishes:
            order_dish = order_model.OrderDish(
                order_id=order_id,
                dish_id=dish_item.dish_id,
                quantity=dish_item.quantity
            )
            db.add(order_dish)

    @staticmethod
    def create_takeaway_order(db: Session, order_data: order_schema.OrderCreate):
        """Create new takeaway order"""
        # Calculate total amount
        total_amount = OrderService.calculate_total_amount(db, order_data.dishes)

        # Create order
        new_order = order_model.Order(
            user_id=order_data.user_id,
            order_type=1,  # Takeaway
            order_date=datetime.utcnow(),
            status=0,  # Chờ xử lý
            total_amount=total_amount,
            delivery_address=order_data.delivery_address,
            created_at=datetime.utcnow(),
            updated_at=datetime.utcnow()
        )
        db.add(new_order)
        db.flush()

        # Create order dishes
        OrderService.create_order_dishes(db, new_order.order_id, order_data.dishes)

        db.commit()
        db.refresh(new_order)
        return new_order

    @staticmethod
    def create_dine_in_order(db: Session, order_data: order_schema.OrderCreate):
        """Create new dine-in order"""
        # Calculate total amount
        total_amount = OrderService.calculate_total_amount(db, order_data.dishes)

        # Create order
        new_order = order_model.Order(
            user_id=order_data.user_id,
            order_type=2,  # Dine-in
            order_date=datetime.utcnow(),
            status=0,  # Chờ xử lý
            total_amount=total_amount,
            created_at=datetime.utcnow(),
            updated_at=datetime.utcnow()
        )
        db.add(new_order)
        db.flush()

        # Create order dishes
        OrderService.create_order_dishes(db, new_order.order_id, order_data.dishes)

        db.commit()
        db.refresh(new_order)
        return new_order

    @staticmethod
    def update_order_status(db: Session, order_id: int, status: int, is_admin: bool):
        """Update order status (admin only)"""
        if not is_admin:
            raise HTTPException(status_code=403, detail="Only admin can update order status")

        if status not in [1, 2, 3, 4]:  # Valid status values
            raise HTTPException(status_code=400, detail="Invalid status value")

        order = db.query(order_model.Order).filter(
            order_model.Order.order_id == order_id
        ).first()
        if not order:
            raise HTTPException(status_code=404, detail="Order not found")

        order.status = status
        order.updated_at = datetime.utcnow()
        
        db.commit()
        db.refresh(order)
        return order

    @staticmethod
    def get_order(db: Session, order_id: int):
        """Get order by ID"""
        order = db.query(order_model.Order).filter(
            order_model.Order.order_id == order_id
        ).first()
        if not order:
            raise HTTPException(status_code=404, detail="Order not found")
        return order

    @staticmethod
    def get_user_orders(db: Session, user_id: int):
        """Get all orders for a user"""
        return db.query(order_model.Order).filter(
            order_model.Order.user_id == user_id
        ).all()
