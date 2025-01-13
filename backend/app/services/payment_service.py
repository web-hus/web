from sqlalchemy.orm import Session
from datetime import datetime
from ..models import ShoppingCart, Payment, Order, OrderDish
from ..schemas import payment_schema
from fastapi import HTTPException
import uuid

class PaymentService:
    @staticmethod
    def create_payment(db: Session, payment_data: payment_schema.PaymentCreate) -> Payment:
        """Create new payment record"""
        # Get order
        order = db.query(Order).filter(Order.order_id == payment_data.order_id).first()
        if not order:
            raise HTTPException(status_code=404, detail="Order not found")

        if order.status != 0:  # Chỉ tạo payment cho đơn hàng chờ xử lý
            raise HTTPException(status_code=400, detail="Order is not in pending status")

        # Create payment
        payment = Payment(
            payment_id=f"P{str(uuid.uuid4())[:3]}",
            user_id=order.user_id,
            order_id=order.order_id,
            amount=payment_data.amount,
            payment_method=payment_data.payment_method,
            payment_status=0  # Đang xử lý
        )
        db.add(payment)
        db.commit()
        db.refresh(payment)

        return payment

    @staticmethod
    def update_payment_status(db: Session, payment_id: str, status: int) -> Payment:
        """Update payment status"""
        payment = db.query(Payment).filter(Payment.payment_id == payment_id).first()
        if not payment:
            raise HTTPException(status_code=404, detail="Payment not found")

        payment.payment_status = status
        payment.payment_date = datetime.now()
        db.commit()
        db.refresh(payment)

        # Nếu thanh toán thành công, cập nhật trạng thái đơn hàng
        if status == 1:  # Đã thanh toán
            order = payment.order
            order.status = 1  # Đã xác nhận
            db.commit()
        elif status == 2:  # Hoàn tiền
            order = payment.order
            order.status = 4  # Hủy
            db.commit()

        return payment

    @staticmethod
    def get_payment(db: Session, payment_id: str) -> Payment:
        """Get payment by ID"""
        payment = db.query(Payment).filter(Payment.payment_id == payment_id).first()
        if not payment:
            raise HTTPException(status_code=404, detail="Payment not found")
        return payment

    @staticmethod
    def get_user_payments(db: Session, user_id: str, skip: int = 0, limit: int = 100):
        """Get all payments for a user"""
        return db.query(Payment)\
                .filter(Payment.user_id == user_id)\
                .order_by(Payment.payment_date.desc())\
                .offset(skip)\
                .limit(limit)\
                .all()
