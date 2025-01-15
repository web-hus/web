from pydantic import BaseModel, Field, ConfigDict
from datetime import datetime, date
from typing import Optional

class BookingBase(BaseModel):
    date: date
    time: str = Field(..., pattern=r'^([01]\d|2[0-3]):([0-5]\d)$')  # Format: HH:MM
    num_people: int = Field(..., gt=0, le=20)  # Giới hạn tối đa 20 người/bàn
    special_requests: Optional[str] = Field(None, max_length=500)

class BookingCreate(BookingBase):
    user_id: int

class BookingUpdate(BaseModel):
    status: int = Field(..., ge=0, le=2)  # 0: Đang chờ, 1: Đã xác nhận, 2: Hủy

class Booking(BookingBase):
    model_config = ConfigDict(from_attributes=True)

    booking_id: int
    user_id: int
    status: int = Field(..., ge=0, le=2)  # 0: Đang chờ, 1: Đã xác nhận, 2: Hủy
    created_at: datetime
    updated_at: datetime
