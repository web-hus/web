from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List

from app.database import SessionLocal

from ..database import get_db
from ..services.order_service import OrderService
from ..schemas.order_schema import OrderCreate, Order
from ..models.tables import Order as OrderModel

from ..auth.auth_bearer import JWTBearer
from ..auth.auth_handler import decodeJWT

router = APIRouter(
    prefix="/orders",
    tags=["orders"],
    # dependencies=[Depends(JWTBearer())]
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

@router.get("/get_orders")
async def get_orders():
    db: Session = SessionLocal()
    dishes = db.query(OrderModel).all()  # Lấy tất cả món ăn từ DB
    db.close()
    return dishes
