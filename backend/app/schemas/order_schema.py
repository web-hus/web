from pydantic import BaseModel, Field, ConfigDict
from typing import List, Optional
from datetime import datetime

class OrderDishBase(BaseModel):
    dish_id: str = Field(..., pattern=r'^D\d{3}$')
    quantity: int = Field(..., gt=0)

class OrderCreate(BaseModel):
    user_id: int
    order_type: int = Field(..., ge=0, le=1)  # 0: Đến quán ăn, 1: Đơn mang về
    booking_id: Optional[int] = None  # Chỉ áp dụng khi user đặt bàn
    delivery_address: Optional[str] = None  # Chỉ áp dụng cho đơn mang về
    dishes: List[OrderDishBase]

class Order(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    order_id: int
    user_id: int
    order_type: int = Field(..., ge=0, le=1)  # 0: Đến quán ăn, 1: Đơn mang về
    booking_id: Optional[int] = None  # Chỉ áp dụng khi user đặt bàn
    status: int = Field(..., ge=0, le=4)  # 0: Chờ xử lý, 1: Đã xác nhận, 2: Đang giao, 3: Hoàn thành, 4: Hủy
    delivery_address: Optional[str] = None  # Chỉ áp dụng cho đơn mang về
    created_at: datetime
    updated_at: datetime

class OrderStatusUpdate(BaseModel):
    status: int = Field(..., ge=0, le=4)  # 0: Chờ xử lý, 1: Đã xác nhận, 2: Đang giao, 3: Hoàn thành, 4: Hủy
