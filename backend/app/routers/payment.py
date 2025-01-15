from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List
from ..database import get_db
from ..schemas.payment_schema import PaymentCreate, Payment
from ..services.payment_service import PaymentService
from ..auth.auth_handler import get_current_user

router = APIRouter(
    prefix="/api/payments",
    tags=["payments"]
)

@router.post("", response_model=Payment)
async def create_payment(
    payment: PaymentCreate,
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """Tạo payment mới"""
    try:
        payment_data = payment.dict()
        payment_data["user_id"] = current_user["user_id"]
        return PaymentService.create_payment(db, payment_data)
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=str(e)
        )

@router.get("/my", response_model=List[Payment])
async def get_my_payments(
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """Lấy danh sách payment của user hiện tại"""
    try:
        return PaymentService.get_user_payments(db, current_user["user_id"])
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=str(e)
        )

@router.get("/{payment_id}", response_model=Payment)
async def get_payment(
    payment_id: int,
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """Lấy thông tin chi tiết một payment"""
    try:
        payment = PaymentService.get_payment(db, payment_id)
        if not payment:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Payment không tồn tại"
            )
        if payment.user_id != current_user["user_id"]:
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="Không có quyền xem payment này"
            )
        return payment
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=str(e)
        )
