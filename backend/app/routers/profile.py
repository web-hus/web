from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from datetime import datetime

from ..database import get_db
from ..models.tables import User
from ..Admin.schemas import admin_schema
from ..auth.auth_bearer import JWTBearer
from ..auth.auth_handler import decodeJWT
from ..core.security import get_password

router = APIRouter(
    prefix="/api/profile",
    tags=["profile"]
)

@router.get("/me", response_model=admin_schema.User)
async def get_profile(
    db: Session = Depends(get_db),
    current_user: dict = Depends(JWTBearer())
):
    """Lấy thông tin cá nhân của user đang đăng nhập"""
    user_data = decodeJWT(current_user)
    user = db.query(User).filter(User.user_id == user_data["user_id"]).first()
    if not user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Không tìm thấy user"
        )
    return user

@router.put("/me", response_model=admin_schema.User)
async def update_profile(
    user_data: admin_schema.UserUpdate,
    db: Session = Depends(get_db),
    current_user: dict = Depends(JWTBearer())
):
    """Cập nhật thông tin cá nhân của user đang đăng nhập"""
    user_id = decodeJWT(current_user)["user_id"]
    user = db.query(User).filter(User.user_id == user_id).first()
    if not user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Không tìm thấy user"
        )

    update_data = user_data.dict(exclude_unset=True)
    
    # Kiểm tra email trùng
    if "email" in update_data and update_data["email"] != user.email:
        if db.query(User).filter(User.email == update_data["email"]).first():
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Email đã tồn tại"
            )

    # Kiểm tra số điện thoại trùng
    if "phone" in update_data and update_data["phone"] != user.phone:
        if db.query(User).filter(User.phone == update_data["phone"]).first():
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Số điện thoại đã tồn tại"
            )

    # Xử lý password nếu có cập nhật
    if "password" in update_data:
        update_data["password"] = get_password(update_data["password"])

    # Cập nhật thông tin
    for key, value in update_data.items():
        setattr(user, key, value)
    
    user.updated_at = datetime.utcnow()
    db.commit()
    db.refresh(user)
    return user
