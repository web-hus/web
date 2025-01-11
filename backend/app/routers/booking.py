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

@router.get("/{booking_id}", response_model=Booking)
def get_booking(
    booking_id: int,
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """Lấy thông tin booking theo ID"""
    booking = BookingService.get_booking(db=db, booking_id=booking_id)
    if current_user["user_id"] != booking.user_id and current_user.get("role") != 1:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Không có quyền xem thông tin booking này"
        )
    return booking

@router.get("/user/{user_id}", response_model=List[Booking])
def get_user_bookings(
    user_id: int,
    skip: int = 0,
    limit: int = 100,
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """Lấy danh sách booking của user"""
    if current_user["user_id"] != user_id and current_user.get("role") != 1:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Không có quyền truy cập bookings của user khác"
        )
    return BookingService.get_user_bookings(db=db, user_id=user_id, skip=skip, limit=limit)

@router.put("/{booking_id}/status", response_model=Booking)
def update_booking_status(
    booking_id: int,
    new_status: int,
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """Cập nhật trạng thái booking"""
    if current_user.get("role") != 1:  # Chỉ admin mới được cập nhật status
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Chỉ admin mới được cập nhật trạng thái booking"
        )
    return BookingService.update_booking_status(db=db, booking_id=booking_id, new_status=new_status)

@router.get("/date/{date}", response_model=List[Booking])
def get_date_bookings(
    date: date,
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """Lấy danh sách booking theo ngày"""
    if current_user.get("role") != 1:  # Chỉ admin mới được xem tất cả bookings
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Chỉ admin mới được xem tất cả bookings"
        )
    return BookingService.get_date_bookings(db=db, date=date)
