from pydantic import BaseModel, Field, ConfigDict
from typing import List, Optional
from datetime import datetime

class CartDishBase(BaseModel):
    dish_id: int
    quantity: int = Field(..., gt=0)

class CartDishCreate(CartDishBase):
    cart_id: int

class CartDish(CartDishBase):
    model_config = ConfigDict(from_attributes=True)
    cart_id: int

class CartBase(BaseModel):
    user_id: int

class CartCreate(CartBase):
    pass

class Cart(CartBase):
    model_config = ConfigDict(from_attributes=True)
    
    cart_id: int
    created_at: datetime
    updated_at: datetime
    dishes: List[CartDish] = []
