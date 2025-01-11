from pydantic import BaseModel, Field
from datetime import datetime, date, time
from typing import Optional

class BookingBase(BaseModel):
    date: date
    time: time
    num_people: int = Field(..., gt=0)
    special_requests: Optional[str] = None

class BookingCreate(BookingBase):
    pass

class Booking(BookingBase):
    booking_id: int
    user_id: int
    status: int
    created_at: datetime
    updated_at: datetime

    class Config:
        orm_mode = True
