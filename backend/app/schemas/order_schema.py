from pydantic import BaseModel, Field, ConfigDict, validator
from typing import List, Optional
from datetime import datetime
import re

class OrderDishBase(BaseModel):
    dish_id: str = Field(..., pattern=r'^D\d{3}$')  # Format: D followed by 3 digits
    quantity: int = Field(..., gt=0)

class OrderBase(BaseModel):
    order_type: int = Field(..., ge=0, le=1)  # 0: Đến quán ăn, 1: Đơn mang về
    booking_id: Optional[int] = None  # Chỉ có khi order_type = 0
    delivery_address: Optional[str] = Field(None, max_length=200)  # Chỉ có khi order_type = 1
    
    @validator('booking_id')
    def validate_booking_id(cls, v, values):
        order_type = values.get('order_type')
        if order_type == 0 and not v:
            raise ValueError('booking_id là bắt buộc khi order_type = 0')
        return v
        
    @validator('delivery_address')
    def validate_delivery_address(cls, v, values):
        order_type = values.get('order_type')
        if order_type == 1 and not v:
            raise ValueError('delivery_address là bắt buộc khi order_type = 1')
        if order_type == 0 and v:
            raise ValueError('delivery_address không được phép khi order_type = 0')
        return v

class OrderCreate(OrderBase):
    user_id: int
    dishes: List[OrderDishBase]

class AdminOrderCreate(OrderCreate):
    phone: str  
    delivery_address: str

class OrderUpdate(BaseModel):
    status: int = Field(..., ge=0, le=4)  # 0: Chờ xử lý, 1: Đã xác nhận, 2: Đang giao, 3: Hoàn thành, 4: Hủy

class Order(OrderBase):
    model_config = ConfigDict(from_attributes=True)

    order_id: int
    user_id: int
    order_date: datetime
    status: int = Field(..., ge=0, le=4)  # 0: Chờ xử lý, 1: Đã xác nhận, 2: Đang giao, 3: Hoàn thành, 4: Hủy
    total_amount: float
    created_at: datetime
    updated_at: datetime
