from pydantic import BaseModel, Field
from typing import List, Optional
from datetime import datetime

class CartDishBase(BaseModel):
    dish_id: str = Field(..., regex=r'^D\d{3}$')
    quantity: int = Field(..., gt=0)

class CartDishCreate(CartDishBase):
    pass

class CartDish(CartDishBase):
    cart_id: int

    class Config:
        orm_mode = True

class ShoppingCartBase(BaseModel):
    user_id: int

class ShoppingCartCreate(ShoppingCartBase):
    pass

class ShoppingCart(ShoppingCartBase):
    cart_id: int
    created_at: datetime
    updated_at: datetime
    dishes: List[CartDish] = []

    class Config:
        orm_mode = True

class PaymentCreate(BaseModel):
    user_id: int
    payment_method: int = Field(..., ge=1, le=3)  
    address: str
    province: str
    district: str
    ward: str
