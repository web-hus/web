from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from ...database import get_db
from ..schemas import admin_schema
from ..services.admin_service import AdminService
from ...auth.auth_bearer import JWTBearer
from ...auth.auth_handler import decodeJWT

router = APIRouter(
    prefix="/admin",
    tags=["admin"],
    dependencies=[Depends(JWTBearer())]
)

def check_admin(token: str = Depends(JWTBearer())):
    user_data = decodeJWT(token)
    if user_data.get("role") != 1:  
        raise HTTPException(status_code=403, detail="Cần quyền truy cập của Admin")
    return user_data

@router.post("/users")
def create_user(
    user_data: admin_schema.UserCreate,
    db: Session = Depends(get_db),
    admin: dict = Depends(check_admin)
):
    """Create new user (admin only)"""
    return AdminService.create_user(db, user_data)

@router.post("/orders/dine-in")
def create_dine_in_order(
    order_data: admin_schema.DineInOrderCreate,
    db: Session = Depends(get_db),
    admin: dict = Depends(check_admin)
):
    """Create dine-in order for walk-in or booked customers (admin only)"""
    return AdminService.create_dine_in_order(db, order_data)

@router.put("/bookings/{booking_id}/status")
def update_booking_status(
    booking_id: int,
    status_data: admin_schema.BookingStatusUpdate,
    db: Session = Depends(get_db),
    admin: dict = Depends(check_admin)
):
    """Update booking status (admin only)"""
    return AdminService.update_booking_status(db, booking_id, status_data.status)

@router.put("/orders/{order_id}/status")
def update_order_status(
    order_id: int,
    status_data: admin_schema.OrderStatusUpdate,
    db: Session = Depends(get_db),
    admin: dict = Depends(check_admin)
):
    """Update order status for takeaway orders (admin only)"""
    return AdminService.update_order_status(db, order_id, status_data.status)
