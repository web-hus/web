from sqlalchemy.orm import Session
from datetime import datetime
from ..models import cart_model, payment_model, order_model
from ..schemas import cart_schema
from fastapi import HTTPException
from ..services.dish_service import DishService
from ..services.order_service import OrderService
from ..core.elasticsearch import get_elasticsearch

class PaymentService:
    @staticmethod
    def create_payment(db: Session, payment_data: cart_schema.PaymentCreate) -> payment_model.Payment:
        """Create new payment record"""
        # Get cart
        cart = db.query(cart_model.ShoppingCart).filter(
            cart_model.ShoppingCart.user_id == payment_data.user_id
        ).first()
        if not cart:
            raise HTTPException(status_code=404, detail="Giỏ hàng không tồn tại")

        if not cart.dishes:
            raise HTTPException(status_code=400, detail="Giỏ hàng trống")

        # Check dish availability
        for cart_dish in cart.dishes:
            DishService.check_dish_availability(db, cart_dish.dish_id)

        # Create order first
        delivery_address = f"{payment_data.address}, {payment_data.ward}, {payment_data.district}, {payment_data.province}"
        order = OrderService.create_takeaway_order(db, cart.user_id, cart.dishes, delivery_address)

        # Create payment record
        payment = payment_model.Payment(
            user_id=payment_data.user_id,
            order_id=order.order_id,
            amount=order.total_amount,
            payment_method=payment_data.payment_method,
            payment_status=0,  # Chờ xử lý
            created_at=datetime.utcnow(),
            updated_at=datetime.utcnow()
        )
        db.add(payment)

        # Clear cart
        db.query(cart_model.ShoppingCartDish).filter(
            cart_model.ShoppingCartDish.cart_id == cart.cart_id
        ).delete()

        # Update cart timestamp
        cart.updated_at = datetime.utcnow()

        # Update Elasticsearch index for affected dishes
        es = get_elasticsearch()
        for cart_dish in cart.dishes:
            DishService.update_dish_availability(db, cart_dish.dish_id, -cart_dish.quantity)

        db.commit()
        db.refresh(payment)
        return payment

    @staticmethod
    def update_payment_status(db: Session, payment_id: int, status: int, is_admin: bool):
        """Update payment status (admin only)"""
        if not is_admin:
            raise HTTPException(status_code=403, detail="Chỉ admin mới có quyền cập nhật trạng thái thanh toán")

        payment = db.query(payment_model.Payment).filter(
            payment_model.Payment.payment_id == payment_id
        ).first()
        if not payment:
            raise HTTPException(status_code=404, detail="Không tìm thấy thanh toán")

        if status not in [1, 2]:  # 1: Thành công, 2: Thất bại
            raise HTTPException(status_code=400, detail="Trạng thái không hợp lệ")

        payment.payment_status = status
        payment.updated_at = datetime.utcnow()

        # If payment failed, update dish availability back
        if status == 2:
            order_dishes = db.query(order_model.OrderDish).filter(
                order_model.OrderDish.order_id == payment.order_id
            ).all()
            for order_dish in order_dishes:
                DishService.update_dish_availability(db, order_dish.dish_id, order_dish.quantity)

        db.commit()
        db.refresh(payment)
        return payment
