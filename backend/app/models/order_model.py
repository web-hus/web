from sqlalchemy import Column, String, Float, DateTime, ForeignKey, Integer, func
from sqlalchemy.orm import relationship
from .base import Base

class Order(Base):
    __tablename__ = "orders"

    order_id = Column(Integer, primary_key=True)
    user_id = Column(Integer, ForeignKey("users.user_id"), nullable=False)
    order_type = Column(Integer, nullable=False)  # 0: Đến quán ăn, 1: Đơn mang về
    booking_id = Column(Integer, ForeignKey("booking.booking_id"), nullable=True)  # Chỉ có khi order_type = 0
    order_date = Column(DateTime, default=func.now())
    status = Column(Integer, default=0)  # 0: Chờ xử lý, 1: Đã xác nhận, 2: Đang giao, 3: Hoàn thành, 4: Hủy
    delivery_address = Column(String(255), nullable=True)  # Chỉ có khi order_type = 1
    created_at = Column(DateTime, default=func.now())
    updated_at = Column(DateTime, default=func.now(), onupdate=func.now())

    # Relationships
    user = relationship("User", back_populates="orders")
    booking = relationship("Booking", back_populates="orders")
    items = relationship("OrderDish", back_populates="order", cascade="all, delete-orphan")
    payment = relationship("Payment", back_populates="order", uselist=False)

class OrderDish(Base):
    __tablename__ = "order_dishes"

    order_id = Column(Integer, ForeignKey("orders.order_id"), primary_key=True)
    dish_id = Column(String(10), ForeignKey("dish.dish_id"), primary_key=True)
    quantity = Column(Integer, nullable=False)

    # Relationships
    order = relationship("Order", back_populates="items")
    dish = relationship("Dish")
