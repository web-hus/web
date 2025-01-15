from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List
from ..database import get_db
from ..schemas.booking_schema import BookingCreate, BookingUpdate, Booking
from ..services.booking_service import BookingService
from ..auth.auth_handler import get_current_user

router = APIRouter(
    prefix="/api/bookings",
    tags=["bookings"]
)

@router.post("", response_model=Booking)
async def create_booking(
    booking: BookingCreate,
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """Tạo booking mới"""
    try:
        booking_data = booking.model_dump()
        booking_data["user_id"] = current_user["user_id"]
        return BookingService.create_booking(db, booking_data)
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=str(e)
        )

@router.get("/my", response_model=List[Booking])
async def get_my_bookings(
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """Lấy danh sách booking của user hiện tại"""
    try:
        return BookingService.get_user_bookings(db, current_user["user_id"])
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=str(e)
        )

@router.get("/{booking_id}", response_model=Booking)
async def get_booking(
    booking_id: int,
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """Lấy thông tin chi tiết một booking"""
    try:
        booking = BookingService.get_booking(db, booking_id)
        if not booking:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Booking không tồn tại"
            )
        if booking.user_id != current_user["user_id"]:
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="Không có quyền xem booking này"
            )
        return booking
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=str(e)
        )
