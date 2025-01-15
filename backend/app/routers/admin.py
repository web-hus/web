from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List
from ..database import get_db
from ..schemas.user_schema import UserCreate, UserUpdate, User
from ..schemas.booking_schema import BookingUpdate
from ..schemas.order_schema import OrderUpdate
from ..schemas.dish_schema import DishCreate, DishUpdate, Dish
from ..services.user_service import UserService
from ..services.booking_service import BookingService
from ..services.order_service import OrderService
from ..services.dish_service import DishService
from ..auth.auth_handler import is_admin
from datetime import datetime
from sqlalchemy.exc import IntegrityError

router = APIRouter(
    prefix="/admin",
    tags=["admin"]
)

@router.post("/users", response_model=User)
async def create_user(
    user: UserCreate, 
    db: Session = Depends(get_db),
    current_user: dict = Depends(is_admin)
):
    """Create new user (admin only)"""
    try:
        # Kiểm tra email đã tồn tại chưa
        existing_user = UserService.get_user_by_email(db, user.email)
        if existing_user:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Email đã được sử dụng"
            )
            
        # Kiểm tra số điện thoại đã tồn tại chưa
        existing_phone = UserService.get_user_by_phone(db, user.phone)
        if existing_phone:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Số điện thoại đã được sử dụng"
            )
            
        return UserService.create_user(db, user.model_dump())
    except HTTPException as e:
        # Re-raise FastAPI HTTP exceptions
        raise e
    except IntegrityError as e:
        db.rollback()
        raise HTTPException(
            status_code=400,
            detail=f"Database integrity error: {str(e)}"
        )
    except Exception as e:
        db.rollback()
        # Log the actual error for debugging
        print(f"Error in create_user: {str(e)}")
        raise HTTPException(
            status_code=500,
            detail="Internal server error while creating user"
        )

@router.put("/users/{identifier}", response_model=User)
async def update_user(
    identifier: str, 
    user: UserUpdate, 
    db: Session = Depends(get_db),
    current_user: dict = Depends(is_admin)
):
    """Update user by email or phone"""
    try:
        return UserService.update_user(db, identifier, user.model_dump(exclude_unset=True))
    except HTTPException as e:
        # Re-raise FastAPI HTTP exceptions
        raise e
    except IntegrityError as e:
        db.rollback()
        raise HTTPException(
            status_code=400,
            detail=f"Database integrity error: {str(e)}"
        )
    except Exception as e:
        db.rollback()
        # Log the actual error for debugging
        print(f"Error in update_user: {str(e)}")
        raise HTTPException(
            status_code=500,
            detail="Internal server error while updating user"
        )

@router.delete("/users/{identifier}")
async def delete_user(
    identifier: str,
    db: Session = Depends(get_db),
    current_user: dict = Depends(is_admin)
):
    """Delete user by email or phone"""
    try:
        return UserService.delete_user(db, identifier)
    except HTTPException as e:
        # Re-raise FastAPI HTTP exceptions
        raise e
    except IntegrityError as e:
        db.rollback()
        raise HTTPException(
            status_code=400,
            detail=f"Database integrity error: {str(e)}"
        )
    except Exception as e:
        db.rollback()
        # Log the actual error for debugging
        print(f"Error in delete_user: {str(e)}")
        raise HTTPException(
            status_code=500,
            detail="Internal server error while deleting user"
        )

@router.put("/bookings/{booking_id}/status")
async def update_booking_status(
    booking_id: int, 
    status_update: BookingUpdate, 
    db: Session = Depends(get_db),
    current_user: dict = Depends(is_admin)
):
    """Update booking status"""
    try:
        return BookingService.update_booking_status(db, booking_id, status_update.status)
    except HTTPException as e:
        # Re-raise FastAPI HTTP exceptions
        raise e
    except IntegrityError as e:
        db.rollback()
        raise HTTPException(
            status_code=400,
            detail=f"Database integrity error: {str(e)}"
        )
    except Exception as e:
        db.rollback()
        # Log the actual error for debugging
        print(f"Error in update_booking_status: {str(e)}")
        raise HTTPException(
            status_code=500,
            detail="Internal server error while updating booking status"
        )

@router.put("/orders/{order_id}/status")
async def update_order_status(
    order_id: int, 
    status_update: OrderUpdate, 
    db: Session = Depends(get_db),
    current_user: dict = Depends(is_admin)
):
    """Update order status"""
    try:
        return OrderService.update_order_status(db, order_id, status_update.status)
    except HTTPException as e:
        # Re-raise FastAPI HTTP exceptions
        raise e
    except IntegrityError as e:
        db.rollback()
        raise HTTPException(
            status_code=400,
            detail=f"Database integrity error: {str(e)}"
        )
    except Exception as e:
        db.rollback()
        # Log the actual error for debugging
        print(f"Error in update_order_status: {str(e)}")
        raise HTTPException(
            status_code=500,
            detail="Internal server error while updating order status"
        )

@router.post("/dishes", response_model=Dish)
async def create_dish(
    dish: DishCreate, 
    db: Session = Depends(get_db),
    current_user: dict = Depends(is_admin)
):
    """Create new dish (admin only)"""
    try:
        return DishService.create_dish(db, dish)
    except HTTPException as e:
        # Re-raise FastAPI HTTP exceptions
        raise e
    except IntegrityError as e:
        db.rollback()
        raise HTTPException(
            status_code=400,
            detail=f"Database integrity error: {str(e)}"
        )
    except Exception as e:
        db.rollback()
        # Log the actual error for debugging
        print(f"Error in create_dish: {str(e)}")
        raise HTTPException(
            status_code=500,
            detail="Internal server error while creating dish"
        )

@router.put("/dishes/{dish_name}", response_model=Dish)
async def update_dish(
    dish_name: str, 
    dish: DishUpdate, 
    db: Session = Depends(get_db),
    current_user: dict = Depends(is_admin)
):
    """Update dish"""
    try:
        return DishService.update_dish(db, dish_name, dish.model_dump(exclude_unset=True))
    except HTTPException as e:
        # Re-raise FastAPI HTTP exceptions
        raise e
    except IntegrityError as e:
        db.rollback()
        raise HTTPException(
            status_code=400,
            detail=f"Database integrity error: {str(e)}"
        )
    except Exception as e:
        db.rollback()
        # Log the actual error for debugging
        print(f"Error in update_dish: {str(e)}")
        raise HTTPException(
            status_code=500,
            detail="Internal server error while updating dish"
        )

@router.delete("/dishes/{dish_name}")
async def delete_dish(
    dish_name: str, 
    db: Session = Depends(get_db),
    current_user: dict = Depends(is_admin)
):
    """Delete dish"""
    try:
        return DishService.delete_dish(db, dish_name)
    except HTTPException as e:
        # Re-raise FastAPI HTTP exceptions
        raise e
    except IntegrityError as e:
        db.rollback()
        raise HTTPException(
            status_code=400,
            detail=f"Database integrity error: {str(e)}"
        )
    except Exception as e:
        db.rollback()
        # Log the actual error for debugging
        print(f"Error in delete_dish: {str(e)}")
        raise HTTPException(
            status_code=500,
            detail="Internal server error while deleting dish"
        )
