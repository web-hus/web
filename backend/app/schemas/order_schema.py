from pydantic import BaseModel, Field, ConfigDict
from typing import List, Optional
from datetime import datetime

class OrderDishBase(BaseModel):
    dish_id: str = Field(..., pattern=r'^D\d{3}$')
    quantity: int = Field(..., gt=0)

class OrderCreate(BaseModel):
    user_id: str = Field(..., pattern=r'^U\d{3}$')
    order_type: int = Field(..., ge=0, le=1)  # 0: Đến quán ăn, 1: Đơn mang về
    booking_id: Optional[str] = Field(None, pattern=r'^B\d{3}$')
    delivery_address: Optional[str] = None
    dishes: List[OrderDishBase]

class AdminOrderCreate(OrderCreate):
    phone: str  
    delivery_address: str

class Order(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    order_id: str = Field(..., pattern=r'^O\d{3}$')
    user_id: str = Field(..., pattern=r'^U\d{3}$')
    order_type: int = Field(..., ge=0, le=1)
    booking_id: Optional[str] = Field(None, pattern=r'^B\d{3}$')
    order_date: datetime
    status: int = Field(..., ge=0, le=4)  # 0: Chờ xử lý, 1: Đã xác nhận, 2: Đang giao, 3: Hoàn thành, 4: Hủy
    total_amount: float
    delivery_address: Optional[str] = None
    created_at: datetime
    updated_at: datetime
