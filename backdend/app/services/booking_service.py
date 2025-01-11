from sqlalchemy.orm import Session
from datetime import datetime
from ..models import booking_model
from ..schemas import booking_schema
from fastapi import HTTPException

class BookingService:
    @staticmethod
    def create_booking(db: Session, booking: booking_schema.BookingCreate, user_id: int):
        """Create a new booking"""
        db_booking = booking_model.Booking(
            user_id=user_id,
            date=booking.date,
            time=booking.time,
            num_people=booking.num_people,
            status=0, 
            special_requests=booking.special_requests,
            created_at=datetime.utcnow(),
            updated_at=datetime.utcnow()
        )
        db.add(db_booking)
        db.commit()
        db.refresh(db_booking)
        return db_booking

    @staticmethod
    def get_booking(db: Session, booking_id: int):
        """Get booking by ID"""
        booking = db.query(booking_model.Booking).filter(
            booking_model.Booking.booking_id == booking_id
        ).first()
        if not booking:
            raise HTTPException(status_code=404, detail="Booking not found")
        return booking

    @staticmethod
    def get_user_bookings(db: Session, user_id: int):
        """Get all bookings for a user"""
        return db.query(booking_model.Booking).filter(
            booking_model.Booking.user_id == user_id
        ).all()

    @staticmethod
    def update_booking_status(db: Session, booking_id: int, status: int, is_admin: bool):
        """Update booking status (admin only)"""
        if not is_admin:
            raise HTTPException(status_code=403, detail="Chỉ admin mới có quyền chỉnh sửa")
        
        if status not in [1, 2]:  
            raise HTTPException(status_code=400, detail="Trạng thái không hợp lệ")

        booking = BookingService.get_booking(db, booking_id)
        booking.status = status
        booking.updated_at = datetime.utcnow()
        
        db.commit()
        db.refresh(booking)
        return booking
