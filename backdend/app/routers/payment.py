from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from ..database import get_db
from ..schemas import cart_schema
from ..services.payment_service import PaymentService
from ..auth.auth_bearer import JWTBearer
from ..auth.auth_handler import decodeJWT

router = APIRouter(
    prefix="/payment",
    tags=["payment"],
    dependencies=[Depends(JWTBearer())]
)

def get_current_user(token: str = Depends(JWTBearer())):
    return decodeJWT(token)

@router.post("/create")
def create_payment(
    payment_data: cart_schema.PaymentCreate,
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """Create new payment from cart"""
    if current_user["user_id"] != payment_data.user_id:
        raise HTTPException(status_code=403, detail="Không có quyền tạo thanh toán cho người dùng khác")
    return PaymentService.create_payment(db, payment_data)

@router.put("/{payment_id}/status")
def update_payment_status(
    payment_id: int,
    status: int,
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """Update payment status (admin only)"""
    is_admin = current_user.get("role") == 1
    return PaymentService.update_payment_status(db, payment_id, status, is_admin)
