from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List
from ..database import get_db
from ..schemas import payment_schema
from ..services.payment_service import PaymentService
from ..auth.auth_bearer import JWTBearer
from ..auth.auth_handler import decodeJWT

router = APIRouter(
    prefix="/payments",
    tags=["payments"],
    dependencies=[Depends(JWTBearer())]
)

def get_current_user(token: str = Depends(JWTBearer())):
    return decodeJWT(token)

@router.post("/create", response_model=payment_schema.Payment)
def create_payment(
    payment_data: payment_schema.PaymentCreate,
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """
    Create new payment
    - Chỉ user đã đăng nhập mới có thể tạo payment
    - User chỉ có thể tạo payment cho chính mình
    """
    if current_user["user_id"] != payment_data.user_id:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN, 
            detail="Không có quyền tạo thanh toán cho người dùng khác"
        )
    return PaymentService.create_payment(db, payment_data)

@router.put("/{payment_id}/status", response_model=payment_schema.Payment)
def update_payment_status(
    payment_id: str,
    status: int,
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """
    Update payment status (admin only)
    - status=0: Đang xử lý
    - status=1: Đã thanh toán
    - status=2: Hoàn tiền
    """
    if current_user.get("role") != 1:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Chỉ admin mới có quyền cập nhật trạng thái thanh toán"
        )
    return PaymentService.update_payment_status(db, payment_id, status)

@router.get("/{payment_id}", response_model=payment_schema.Payment)
def get_payment(
    payment_id: str,
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """Get payment details by ID"""
    payment = PaymentService.get_payment(db, payment_id)
    if payment.user_id != current_user["user_id"] and current_user.get("role") != 1:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Không có quyền xem thông tin thanh toán này"
        )
    return payment

@router.get("/user/{user_id}", response_model=List[payment_schema.Payment])
def get_user_payments(
    user_id: str,
    skip: int = 0,
    limit: int = 100,
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """
    Get all payments for a user
    - User chỉ có thể xem payment của chính mình
    - Admin có thể xem payment của tất cả users
    """
    if user_id != current_user["user_id"] and current_user.get("role") != 1:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Không có quyền xem lịch sử thanh toán của người dùng khác"
        )
    return PaymentService.get_user_payments(db, user_id, skip, limit)
