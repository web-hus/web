from pydantic import BaseModel
from typing import List, Optional
from datetime import datetime
from .dish_schema import Dish

class CartDishBase(BaseModel):
    dish_id: str
    quantity: int

class CartDish(CartDishBase):
    dish: Dish

    class Config:
        from_attributes = True

class CartBase(BaseModel):
    user_id: int
    created_at: datetime
    updated_at: datetime

class Cart(CartBase):
    cart_id: int
    dishes: List[CartDish]

    class Config:
        from_attributes = True
