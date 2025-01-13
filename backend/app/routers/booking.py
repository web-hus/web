from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List
from datetime import date

from ..database import get_db
from ..services.booking_service import BookingService
from ..schemas.booking_schema import BookingCreate, Booking
from ..auth.auth_bearer import JWTBearer
from ..auth.auth_handler import decodeJWT

router = APIRouter(
    prefix="/bookings",
    tags=["bookings"],
    dependencies=[Depends(JWTBearer())]
)

def get_current_user(token: str = Depends(JWTBearer())):
    return decodeJWT(token)

@router.post("/", response_model=Booking)
def create_booking(
    booking: BookingCreate,
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """Tạo booking mới"""
    return BookingService.create_booking(db=db, booking_data=booking)

@router.put("/{booking_id}/status")
def update_booking_status(
    booking_id: int,
    new_status: int,
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """Cập nhật trạng thái booking"""
    booking = BookingService.get_booking(db=db, booking_id=booking_id)
    if not booking:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Không tìm thấy booking"
        )
    if current_user["user_id"] != booking.user_id and current_user.get("role") != 1:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Không có quyền cập nhật trạng thái booking này"
        )
    return BookingService.update_booking_status(db=db, booking_id=booking_id, new_status=new_status)
