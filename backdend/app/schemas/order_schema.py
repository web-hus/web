from pydantic import BaseModel, Field
from typing import List, Optional
from datetime import datetime

class OrderDishBase(BaseModel):
    dish_id: str = Field(..., regex=r'^D\d{3}$')
    quantity: int = Field(..., gt=0)

class OrderCreate(BaseModel):
    user_id: int
    order_type: int = Field(..., ge=0, le=1)
    booking_id: Optional[int] = None
    delivery_address: Optional[str] = None
    dishes: List[OrderDishBase]

class AdminOrderCreate(OrderCreate):
    phone: str  
    delivery_address: str

class Order(BaseModel):
    order_id: int
    user_id: int
    order_type: int
    booking_id: Optional[int]
    order_date: datetime
    status: int
    total_amount: float
    delivery_address: Optional[str]
    created_at: datetime
    updated_at: datetime

    class Config:
        orm_mode = True
