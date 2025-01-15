from sqlalchemy import Column, String, Float, DateTime, ForeignKey, Integer, func
from sqlalchemy.orm import relationship
from .base import Base

class Payment(Base):
    __tablename__ = "payment"

    payment_id = Column(Integer, primary_key=True,autoincrement=True)
    user_id = Column(Integer, ForeignKey("users.user_id"), nullable=False)
    order_id = Column(Integer, ForeignKey("orders.order_id"), nullable=False)
    amount = Column(Float, nullable=False)
    payment_method = Column(Integer, nullable=False)  # 0: Online, 1: Khi nhận hàng
    payment_status = Column(Integer, default=0)  # 0: Đang xử lý, 1: Đã thanh toán, 2: Hoàn tiền
    payment_date = Column(DateTime, default=func.now())

    # Relationships
    user = relationship("User")
    order = relationship("Order", back_populates="payment")
