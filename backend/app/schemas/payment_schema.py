from pydantic import BaseModel, Field, confloat
from typing import Optional
from datetime import datetime

class PaymentBase(BaseModel):
    cart_id: str = Field(..., pattern=r'^C\d{3}$')
    amount: confloat(gt=0)
    payment_method: str = Field(..., pattern=r'^(cash|credit_card|bank_transfer)$')
    status: str = Field(default="pending", pattern=r'^(pending|completed|failed)$')

class PaymentCreate(PaymentBase):
    pass

class PaymentUpdate(BaseModel):
    status: Optional[str] = Field(None, pattern=r'^(pending|completed|failed)$')
    payment_method: Optional[str] = Field(None, pattern=r'^(cash|credit_card|bank_transfer)$')

class Payment(PaymentBase):
    payment_id: str = Field(..., pattern=r'^P\d{3}$')
    user_id: str = Field(..., pattern=r'^U\d{3}$')
    created_at: datetime = Field(default_factory=datetime.now)
    updated_at: datetime = Field(default_factory=datetime.now)

    class Config:
        from_attributes = True
