from sqlalchemy import Column, String, Float, Text, Integer, DateTime, func, CheckConstraint
from .base import Base

class Dish(Base):
    __tablename__ = 'dish'
    
    dish_id = Column(String(10), primary_key=True)
    dish_name = Column(String(100), nullable=False)
    product_category = Column(String(25), nullable=False)
    price = Column(Float, nullable=False)
    description = Column(Text)
    created_at = Column(DateTime, default=func.now())
    availability = Column(Integer, default=1)  # 0: hết hàng, 1: còn hàng

    __table_args__ = (
        CheckConstraint('availability IN (0, 1)', name='check_availability'),
    )

    def __repr__(self):
        return f"<Dish(dish_id={self.dish_id}, dish_name={self.dish_name}, price={self.price})>"
