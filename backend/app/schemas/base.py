from pydantic import BaseModel, EmailStr, constr, validator
from typing import Optional
from datetime import datetime
import re

class UserBase(BaseModel):
    user_name: constr(min_length=2, max_length=50)
    age: int
    gender: constr(regex="^[MF]$")
    address: constr(min_length=5, max_length=200)
    email: EmailStr
    phone: constr(regex="^[0-9]{10}$")
    
    @validator('age')
    def validate_age(cls, v):
        if v < 18 or v > 100:
            raise ValueError('Age must be between 18 and 100')
        return v

class UserCreate(UserBase):
    password: constr(min_length=8)
    
    @validator('password')
    def validate_password(cls, v):
        if not re.match(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$', v):
            raise ValueError('Password must contain at least one letter and one number')
        return v

class DishBase(BaseModel):
    dish_name: constr(min_length=2, max_length=100)
    product_category: constr(min_length=2, max_length=50)
    price: float
    description: Optional[str] = None
    availability: bool = True
    
    @validator('price')
    def validate_price(cls, v):
        if v <= 0:
            raise ValueError('Price must be greater than 0')
        return v

class BookingBase(BaseModel):
    date: datetime
    time: str
    num_people: int
    special_requests: Optional[str] = None
    
    @validator('num_people')
    def validate_num_people(cls, v):
        if v < 1 or v > 20:
            raise ValueError('Number of people must be between 1 and 20')
        return v
    
    @validator('time')
    def validate_time(cls, v):
        if not re.match(r'^([01]?[0-9]|2[0-3]):[0-5][0-9]$', v):
            raise ValueError('Time must be in HH:MM format')
        return v

class OrderBase(BaseModel):
    order_type: int
    booking_id: Optional[int] = None
    delivery_address: Optional[str] = None
    
    @validator('order_type')
    def validate_order_type(cls, v):
        if v not in [0, 1]:
            raise ValueError('Order type must be 0 (dine-in) or 1 (takeaway)')
        return v

class PaymentBase(BaseModel):
    amount: float
    payment_method: int
    
    @validator('payment_method')
    def validate_payment_method(cls, v):
        if v not in [0, 1]:
            raise ValueError('Payment method must be 0 (online) or 1 (cash)')
        return v
    
    @validator('amount')
    def validate_amount(cls, v):
        if v <= 0:
            raise ValueError('Amount must be greater than 0')
        return v

class CartItemBase(BaseModel):
    dish_id: str
    quantity: int
    
    @validator('quantity')
    def validate_quantity(cls, v):
        if v < 1:
            raise ValueError('Quantity must be at least 1')
        return v
    
    @validator('dish_id')
    def validate_dish_id(cls, v):
        if not re.match(r'^D\d{3}$', v):
            raise ValueError('Dish ID must be in format D followed by 3 digits')
        return v
