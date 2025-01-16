from sqlalchemy import Column, String, Integer, Float, DateTime, ForeignKey, func
from sqlalchemy.orm import relationship
from .base import Base

class ShoppingCart(Base):
    __tablename__ = "shopping_cart"

    cart_id = Column(Integer, primary_key=True)
    user_id = Column(Integer, ForeignKey("users.user_id"), nullable=False)
    created_at = Column(DateTime, default=func.now())
    updated_at = Column(DateTime, default=func.now(), onupdate=func.now())

    user = relationship("User", back_populates="cart")
    dishes = relationship("ShoppingCartDish", back_populates="cart", cascade="all, delete-orphan")

class ShoppingCartDish(Base):
    __tablename__ = "shopping_cart_dishes"

    cart_id = Column(Integer, ForeignKey("shopping_cart.cart_id"), primary_key=True)
    dish_id = Column(String(10), ForeignKey("dish.dish_id"), primary_key=True)
    quantity = Column(Integer, nullable=False)

    # Relationships
    cart = relationship("ShoppingCart", back_populates="dishes")
    dish = relationship("Dish")


    # Relationships
    user = relationship("User")
    order = relationship("Order")
