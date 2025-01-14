from sqlalchemy.orm import Session
from fastapi import Depends
from datetime import datetime
from ..models import user_model
from fastapi import HTTPException
from ..core.security import get_password, verify_password

class UserService:
    @staticmethod
    def authenticate_user(db: Session, email: str, password: str):
        """Authenticate user with email and password"""
        user = UserService.get_user_by_email(db, email)
        if not user:
            return None
        if not verify_password(password, user.password):
            return None
        return user

    @staticmethod
    def get_users(db: Session, skip: int = 0, limit: int = 100, search: str = None):
        """Get list of users with optional name search"""
        query = db.query(user_model.User)
        if search:
            query = query.filter(user_model.User.user_name.ilike(f"%{search}%"))
        return query.offset(skip).limit(limit).all()

    @staticmethod
    async def get_user_by_email(db: Session, email: str):
        """Get user by email"""
        return db.query(user_model.User).filter(user_model.User.email == email).first()

    @staticmethod
    async def get_user_by_phone(db: Session, phone: str):
        """Get user by phone"""
        return db.query(user_model.User).filter(user_model.User.phone == phone).first()

    @staticmethod
    async def create_user(db: Session, user_data: dict):
        """Create new user"""
        if await UserService.get_user_by_email(db=db, email=user_data["email"]):
            raise HTTPException(status_code=400, detail="Email đã được đăng ký")
        
        if await UserService.get_user_by_phone(db=db, phone=user_data["phone"]):
            raise HTTPException(status_code=400, detail="Số điện thoại đã được đăng ký")

        user_data["created_at"] = datetime.utcnow()
        user_data["updated_at"] = datetime.utcnow()
        user_data["role"] = 0  # 0: Customer, 1: Admin
        user_data["password"] = get_password(user_data["password"])

        db_user = user_model.User(**user_data)
        
        db.add(db_user)
        db.commit()
        db.refresh(db_user)
        return db_user

    @staticmethod
    async def delete_user(db: Session, user_id: int):
        """Delete user account"""
        user = db.query(user_model.User).filter(user_model.User.user_id == user_id).first()
        if not user:
            raise HTTPException(status_code=404, detail="Không tìm thấy người dùng")

        if user.role == 1:
            raise HTTPException(status_code=400, detail="Không thể xóa tài khoản admin")

        db.delete(user)
        db.commit()
        return {"message": "Đã xóa tài khoản thành công"}

    @staticmethod
    async def authenticate_user(db: Session, email: str, password: str):
        """Authenticate user by email and password"""
        user = await UserService.get_user_by_email(db=db, email=email)
        if not user:
            return False
        if not user.verify_password(password):
            return False
        return user
