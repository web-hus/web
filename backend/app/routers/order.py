from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List

from ..database import get_db
from ..services.order_service import OrderService
from ..schemas.order_schema import OrderCreate, Order, OrderUpdate
from ..auth.auth_bearer import JWTBearer
from ..auth.auth_handler import get_current_user
from ..middleware.admin_check import admin_required

router = APIRouter(
    prefix="/orders",
    tags=["orders"],
    dependencies=[Depends(JWTBearer())]
)

@router.post("/", response_model=Order)
def create_order(
    order: OrderCreate,
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """Tạo đơn hàng mới"""
    if current_user["user_id"] != order.user_id:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Không thể tạo đơn hàng cho user khác"
        )
    return OrderService.create_order(db=db, order_data=order)

@router.get("/{order_id}", response_model=Order)
def get_order(
    order_id: int,
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """Lấy thông tin đơn hàng theo ID"""
    order = OrderService.get_order(db=db, order_id=order_id)
    if current_user["user_id"] != order.user_id and current_user.get("role") != 1:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Không có quyền xem thông tin đơn hàng này"
        )
    return order

@router.get("/user/{user_id}", response_model=List[Order])
def get_user_orders(
    user_id: int,
    skip: int = 0,
    limit: int = 100,
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """Lấy danh sách đơn hàng của user"""
    if current_user["user_id"] != user_id and current_user.get("role") != 1:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Không có quyền truy cập đơn hàng của user khác"
        )
    return OrderService.get_user_orders(db=db, user_id=user_id, skip=skip, limit=limit)

@router.get("/booking/{booking_id}", response_model=List[Order])
def get_booking_orders(
    booking_id: int,
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """Lấy danh sách đơn hàng theo booking"""
    # Kiểm tra quyền truy cập booking
    orders = OrderService.get_booking_orders(db=db, booking_id=booking_id)
    if orders and current_user["user_id"] != orders[0].user_id and current_user.get("role") != 1:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Không có quyền xem đơn hàng của booking này"
        )
    return orders

@router.get("/status")
async def get_order_status(
    current_user: dict = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Get order status for current user with status in [0, 1, 2]"""
    orders = OrderService.get_orders_by_status(
        db, 
        current_user["user_id"], 
        status_list=[0, 1, 2]
    )
    return {
        "orders": [
            {
                "order_id": order.order_id,
                "status": order.status,
                "created_at": order.created_at
            } for order in orders
        ]
    }

@router.put("/{order_id}/status", dependencies=[Depends(admin_required)], response_model=Order)
async def update_order_status(
    order_id: int,
    order_update: OrderUpdate,
    db: Session = Depends(get_db)
):
    """Cập nhật trạng thái đơn hàng"""
    return OrderService.update_order_status(db, order_id, order_update.status)
