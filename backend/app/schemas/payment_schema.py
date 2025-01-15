from pydantic import BaseModel, Field, ConfigDict
from datetime import datetime
from typing import Optional

class PaymentBase(BaseModel):
    amount: float = Field(..., gt=0)
    payment_method: int = Field(..., ge=0, le=1)  # 0: Online, 1: Khi nhận hàng

class PaymentCreate(PaymentBase):
    user_id: int
    order_id: int

class PaymentUpdate(BaseModel):
    payment_status: int = Field(..., ge=0, le=2)  # 0: Đang xử lý, 1: Đã thanh toán, 2: Hoàn tiền

class Payment(PaymentBase):
    model_config = ConfigDict(from_attributes=True)

    payment_id: int
    user_id: int
    order_id: int
    payment_status: int = Field(..., ge=0, le=2)
    payment_date: datetime
