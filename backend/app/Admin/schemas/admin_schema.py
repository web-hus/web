from pydantic import BaseModel, EmailStr, Field
from typing import Optional
from datetime import datetime

class UserCreate(BaseModel):
    user_name: str
    age: int = Field(..., gt=0)
    gender: str = Field(..., regex='^[MF]$')  
    address: str
    email: EmailStr
    phone: str
    password: str
    role: int = Field(0, ge=0, le=1) 

class OrderStatusUpdate(BaseModel):
    order_id: int
    status: int = Field(..., ge=0, le=4)

class BookingStatusUpdate(BaseModel):
    booking_id: int
    status: int = Field(..., ge=1, le=2)

class DineInOrderCreate(BaseModel):
    user_id: Optional[int] = None
    booking_id: Optional[int] = None
    phone: Optional[str] = None
    email: Optional[str] = None
    dishes: list[dict] = Field(..., min_items=1)  
