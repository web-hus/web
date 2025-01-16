from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from ...database import get_db
from ..schemas import admin_schema
from ..services.admin_service import AdminService
from ...auth.auth_bearer import JWTBearer
from ...auth.auth_handler import get_current_user
from ...schemas.dish_schema import DishCreate, Dish
from ...schemas.user_schema import User, UserResponse
from typing import List
from fastapi import status
from ...models.user_model import User as UserModel
from ...models.shopping_cart_model import ShoppingCart, ShoppingCartDish
from ...schemas.cart_schema import Cart

router = APIRouter(
    prefix="/admin",
    tags=["admin"],
    dependencies=[Depends(JWTBearer())]
)

def get_current_admin(token: str = Depends(JWTBearer())):
    user_data = get_current_user(token)
    if not user_data or user_data.get("role") != 1:
        raise HTTPException(
            status_code=403,
            detail="Cần quyền truy cập của Admin"
        )
    return user_data

def get_current_admin_user(token: str = Depends(JWTBearer())):
    user_data = get_current_user(token)
    if not user_data or user_data.get("role") != 1:
        raise HTTPException(
            status_code=403,
            detail="Cần quyền truy cập của Admin"
        )
    return User(**user_data)

@router.post("/users")
def create_user(
    user_data: admin_schema.UserCreate,
    db: Session = Depends(get_db),
    admin: dict = Depends(get_current_admin)
):
    """Create new user (admin only)"""
    return AdminService.create_user(db, user_data)

@router.post("/dishes", response_model=Dish)
async def create_dish(
    dish_data: DishCreate,
    db: Session = Depends(get_db),
    admin: dict = Depends(get_current_admin)
):
    """Create new dish (admin only)"""
    try:
        return AdminService.create_dish(db, dish_data)
    except HTTPException as e:
        raise e
    except Exception as e:
        raise HTTPException(
            status_code=500,
            detail=f"Internal server error: {str(e)}"
        )

@router.post("/orders/dine-in")
def create_dine_in_order(
    order_data: admin_schema.DineInOrderCreate,
    db: Session = Depends(get_db),
    admin: dict = Depends(get_current_admin)
):
    """Create dine-in order for walk-in or booked customers (admin only)"""
    return AdminService.create_dine_in_order(db, order_data)

@router.put("/bookings/{booking_id}/status")
def update_booking_status(
    booking_id: int,
    status_data: admin_schema.BookingStatusUpdate,
    db: Session = Depends(get_db),
    admin: dict = Depends(get_current_admin)
):
    """Update booking status (admin only)"""
    return AdminService.update_booking_status(db, booking_id, status_data.status)

@router.put("/orders/{order_id}/status")
def update_order_status(
    order_id: int,
    status_data: admin_schema.OrderStatusUpdate,
    db: Session = Depends(get_db),
    admin: dict = Depends(get_current_admin)
):
    """Update order status for takeaway orders (admin only)"""
    return AdminService.update_order_status(db, order_id, status_data.status)

# Lấy danh sách người dùng
@router.get("/users", response_model=List[UserResponse], summary="Get all users")
async def get_users(
    skip: int = 0, 
    limit: int = 100, 
    db: Session = Depends(get_db),
    admin: dict = Depends(get_current_admin)
):
    """Get list of all users (Admin only)"""
    try:
        users = db.query(UserModel).offset(skip).limit(limit).all()
        return users
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Error getting users: {str(e)}"
        )

# Lấy danh sách giỏ hàng của tất cả người dùng
@router.get("/carts", response_model=List[Cart], summary="Get all shopping carts")
async def get_all_carts(
    skip: int = 0,
    limit: int = 100,
    db: Session = Depends(get_db),
    admin: dict = Depends(get_current_admin)
):
    """Get all users' shopping carts (Admin only)"""
    try:
        carts = (
            db.query(ShoppingCart)
            .options(joinedload(ShoppingCart.dishes).joinedload(ShoppingCartDish.dish))
            .offset(skip)
            .limit(limit)
            .all()
        )
        return carts
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Error getting carts: {str(e)}"
        )

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