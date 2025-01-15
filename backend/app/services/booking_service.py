from sqlalchemy.orm import Session
from datetime import datetime, date
from fastapi import HTTPException, status
from ..models.tables import Booking, User
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

    @staticmethod
    def find_booking_by_criteria(db: Session, booking_date: date, phone: str):
        """Find booking by date and phone number with status 0"""
        user = db.query(User).filter(User.phone == phone).first()
        if not user:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Không tìm thấy người dùng với số điện thoại này"
            )

        booking = db.query(Booking).filter(
            Booking.user_id == user.user_id,
            Booking.date == booking_date,
            Booking.status == 0
        ).first()

        if not booking:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Không tìm thấy đơn đặt bàn phù hợp"
            )

        return booking

    @staticmethod
    def update_booking_status_by_criteria(db: Session, booking_date: date, phone: str, new_status: int):
        """Update booking status by date and phone"""
        booking = BookingService.find_booking_by_criteria(db, booking_date, phone)
        
        booking.status = new_status
        db.commit()
        db.refresh(booking)
        return booking
