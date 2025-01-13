from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List

from ..database import get_db
from ..services.payment_service import PaymentService
from ..services.user_service import UserService
from ..schemas.payment_schema import PaymentCreate, Payment, PaymentStatusUpdate
from ..auth.auth_bearer import JWTBearer
from ..auth.auth_handler import decodeJWT

router = APIRouter(
    prefix="/payments",
    tags=["payments"],
    dependencies=[Depends(JWTBearer())]
)

def get_current_user(token: str = Depends(JWTBearer())):
    return decodeJWT(token)

@router.post("/", response_model=Payment)
def create_payment(
    payment: PaymentCreate,
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """Tạo payment mới"""
    if current_user["user_id"] != payment.user_id and current_user.get("role") != 1:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Không có quyền tạo payment cho user khác"
        )
    return PaymentService.create_payment(db=db, payment_data=payment)

@router.put("/user/status")
def update_payment_status_by_user(
    phone_or_email: str,
    status_data: PaymentStatusUpdate,
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    user = None
    if "@" in phone_or_email:  # Là email
        user = UserService.get_user_by_email(db=db, email=phone_or_email)
    else:  # Là phone
        user = UserService.get_user_by_phone(db=db, phone=phone_or_email)
    
    if not user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Không tìm thấy user với phone/email này"
        )

    # Tìm payment mới nhất của user
    payment = PaymentService.get_latest_user_payment(db=db, user_id=user.user_id)
    if not payment:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Không tìm thấy payment của user này"
        )

    # Kiểm tra quyền
    if current_user["user_id"] != user.user_id and current_user.get("role") != 1:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Không có quyền cập nhật payment của user khác"
        )

    return PaymentService.update_payment_status(db=db, payment_id=payment.payment_id, new_status=status_data.status)
