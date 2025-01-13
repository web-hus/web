from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List

from ...database import get_db
from ...models.tables import User
from ..schemas import admin_schema, dish_schema
from ..services.admin_service import AdminService
from ..services.dish_service import DishService
from ...auth.auth_bearer import JWTBearer
from ...auth.auth_handler import decodeJWT

router = APIRouter(
    prefix="/api/admin",
    tags=["admin"],
    dependencies=[Depends(JWTBearer())]
)

def get_current_admin(db: Session = Depends(get_db), token: str = Depends(JWTBearer())) -> User:
    """Get current admin from token"""
    payload = decodeJWT(token)
    user = db.query(User).filter(User.user_id == payload["user_id"]).first()
    if not user or user.role != 1:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Không có quyền admin"
        )
    return user

# User management routes
@router.post("/users", response_model=admin_schema.User)
async def create_user(
    user: admin_schema.UserCreate,
    db: Session = Depends(get_db),
    current_admin: User = Depends(get_current_admin)
):
    """Create new user"""
    return AdminService.create_user(db, user)

@router.put("/users/{user_id}", response_model=admin_schema.User)
async def update_user(
    user_id: int,
    user: admin_schema.UserUpdate,
    db: Session = Depends(get_db),
    current_admin: User = Depends(get_current_admin)
):
    """Update user"""
    return AdminService.update_user(db, user_id, user, current_admin.user_id)

@router.delete("/users/{user_id}", response_model=admin_schema.User)
async def delete_user(
    user_id: int,
    db: Session = Depends(get_db),
    current_admin: User = Depends(get_current_admin)
):
    """Delete user"""
    return AdminService.delete_user(db, user_id, current_admin.user_id)

# Dish management routes
@router.post("/dishes", response_model=dish_schema.Dish)
async def create_dish(
    dish: dish_schema.DishCreate,
    db: Session = Depends(get_db),
    current_admin: User = Depends(get_current_admin)
):
    """Create new dish"""
    return DishService.create_dish(db, dish)

@router.get("/dishes/{dish_id}", response_model=dish_schema.Dish)
async def get_dish(
    dish_id: int,
    db: Session = Depends(get_db),
    current_admin: User = Depends(get_current_admin)
):
    """Get dish by ID"""
    db_dish = DishService.get_dish(db, dish_id)
    if not db_dish:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Không tìm thấy món ăn"
        )
    return db_dish

@router.put("/dishes/{dish_id}", response_model=dish_schema.Dish)
async def update_dish(
    dish_id: int,
    dish: dish_schema.DishUpdate,
    db: Session = Depends(get_db),
    current_admin: User = Depends(get_current_admin)
):
    """Update dish"""
    return DishService.update_dish(db, dish_id, dish)

@router.delete("/dishes/{dish_id}", response_model=dish_schema.Dish)
async def delete_dish(
    dish_id: int,
    db: Session = Depends(get_db),
    current_admin: User = Depends(get_current_admin)
):
    """Delete dish"""
    return DishService.delete_dish(db, dish_id)

@router.post("/orders/dine-in")
async def create_dine_in_order(
    order_data: admin_schema.DineInOrderCreate,
    db: Session = Depends(get_db),
    current_admin: User = Depends(get_current_admin)
):
    """Create dine-in order"""
    return AdminService.create_dine_in_order(db, order_data)

@router.put("/bookings/{booking_id}/status")
async def update_booking_status(
    booking_id: int,
    status_data: admin_schema.BookingStatusUpdate,
    db: Session = Depends(get_db),
    current_admin: User = Depends(get_current_admin)
):
    """Update booking status"""
    return AdminService.update_booking_status(db, booking_id, status_data.status)

@router.put("/orders/{order_id}/status")
async def update_order_status(
    order_id: int,
    status_data: admin_schema.OrderStatusUpdate,
    db: Session = Depends(get_db),
    current_admin: User = Depends(get_current_admin)
):
    """Update order status"""
    return AdminService.update_order_status(db, order_id, status_data.status)