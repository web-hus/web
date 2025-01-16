from pydantic import BaseModel, Field, ConfigDict
from typing import Optional
from datetime import datetime

class PaymentBase(BaseModel):
    user_id: int
    order_id: int
    amount: float = Field(..., gt=0)
    payment_method: int = Field(..., ge=0, le=1)  # 0: Online, 1: Khi nhận hàng
    payment_status: int = Field(..., ge=0, le=2)  # 0: Đang xử lý, 1: Đã thanh toán, 2: Hoàn tiền
    payment_date: datetime

class PaymentCreate(BaseModel):
    user_id: int
    order_id: int
    amount: float = Field(..., gt=0)
    payment_method: int = Field(..., ge=0, le=1)  # 0: Online, 1: Cash on delivery
    payment_status: int = Field(..., ge=0, le=2)  # 0: Processing, 1: Paid, 2: Refunded


class PaymentStatusUpdate(BaseModel):
    status: int = Field(..., ge=0, le=2)  # 0: Đang xử lý, 1: Đã thanh toán, 2: Hoàn tiền

class Payment(PaymentBase):
    model_config = ConfigDict(from_attributes=True)
    
    payment_id: int
