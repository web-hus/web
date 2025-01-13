from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List

from ..database import get_db
from ..services.order_service import OrderService
from ..schemas.order_schema import OrderCreate, Order
from ..auth.auth_bearer import JWTBearer
from ..auth.auth_handler import decodeJWT

router = APIRouter(
    prefix="/orders",
    tags=["orders"],
    dependencies=[Depends(JWTBearer())]
)

def get_current_user(token: str = Depends(JWTBearer())):
    return decodeJWT(token)

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

@router.put("/{order_id}/status")
def update_order_status(
    order_id: int,
    new_status: int,
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """
    Cập nhật trạng thái đơn hàng
    - status=0: Chờ xử lý
    - status=1: Đã xác nhận
    - status=2: Đang giao
    - status=3: Hoàn thành
    - status=4: Hủy
    """
    order = OrderService.get_order(db=db, order_id=order_id)
    if not order:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Không tìm thấy đơn hàng"
        )
    if current_user["user_id"] != order.user_id and current_user.get("role") != 1:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Không có quyền cập nhật trạng thái đơn hàng này"
        )
    return OrderService.update_order_status(db=db, order_id=order_id, new_status=new_status)
