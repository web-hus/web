from sqlalchemy.orm import Session
from datetime import datetime
from fastapi import HTTPException, status
from ..models.tables import Booking
from ..schemas import booking_schema

class BookingService:
    @staticmethod
    def create_booking(db: Session, booking_data: booking_schema.BookingCreate) -> Booking:
        """Create a new booking"""
        db_booking = Booking(
            user_id=booking_data.user_id,
            date=booking_data.date,
            time=booking_data.time,
            num_people=booking_data.num_people,
            status=0,  # Đang chờ
            special_requests=booking_data.special_requests,
            created_at=datetime.utcnow(),
            updated_at=datetime.utcnow()
        )
        db.add(db_booking)
        db.commit()
        db.refresh(db_booking)
        return db_booking

    @staticmethod
    def get_booking(db: Session, booking_id: int) -> Booking:
        """Get booking by ID"""
        booking = db.query(Booking).filter(Booking.booking_id == booking_id).first()
        if not booking:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Không tìm thấy booking"
            )
        return booking

    @staticmethod
    def get_user_bookings(db: Session, user_id: int, skip: int = 0, limit: int = 100) -> list[Booking]:
        """Get all bookings for a user with pagination"""
        return db.query(Booking).filter(
            Booking.user_id == user_id
        ).offset(skip).limit(limit).all()

    @staticmethod
    def update_booking_status(db: Session, booking_id: int, new_status: int) -> Booking:
        """Update booking status"""
        booking = BookingService.get_booking(db, booking_id)
        if booking.status == 2:  # Đã hủy
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Không thể cập nhật trạng thái của booking đã hủy"
            )
        booking.status = new_status
        db.commit()
        db.refresh(booking)
        return booking

    @staticmethod
    def get_date_bookings(db: Session, date: datetime.date) -> list[Booking]:
        """Get all bookings for a specific date"""
        return db.query(Booking).filter(Booking.date == date).all()
