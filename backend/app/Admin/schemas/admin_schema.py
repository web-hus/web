from pydantic import BaseModel, EmailStr, Field
from typing import Optional
from datetime import datetime

class UserCreate(BaseModel):
    user_name: str
    age: int = Field(..., gt=0)
    gender: str = Field(..., pattern='^[MF]$')  
    address: str
    email: EmailStr
    phone: str = Field(..., pattern=r'^\+?[0-9]{10,12}$')
    password: str
    role: int = Field(0, ge=0, le=1) 

class UserUpdate(BaseModel):
    user_name: Optional[str] = None
    age: Optional[int] = Field(None, gt=0)
    gender: Optional[str] = Field(None, pattern='^[MF]$')
    address: Optional[str] = None
    email: Optional[EmailStr] = None
    phone: Optional[str] = Field(None, pattern=r'^\+?[0-9]{10,12}$')
    password: Optional[str] = None

class User(BaseModel):
    model_config = {
        "from_attributes": True
    }
    
    user_id: int
    user_name: str
    age: int
    gender: str
    address: str
    email: str
    phone: str
    role: int
    created_at: datetime
    updated_at: datetime

class OrderStatusUpdate(BaseModel):
    order_id: int
    status: int = Field(..., ge=0, le=4)

class BookingStatusUpdate(BaseModel):
    booking_id: int
    status: int = Field(..., ge=1, le=2)

class DineInOrderCreate(BaseModel):
    user_id: Optional[int] = None
    booking_id: Optional[int] = None
    phone: Optional[str] = Field(None, pattern=r'^\+?[0-9]{10,12}$')
    email: Optional[EmailStr] = None
    dishes: list[dict] = Field(..., min_items=1)  
