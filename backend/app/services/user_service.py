from sqlalchemy.orm import Session
from datetime import datetime
from ..models import user_model
from fastapi import HTTPException

class UserService:
    @staticmethod
    def get_users(db: Session, skip: int = 0, limit: int = 100, search: str = None):
        """Get list of users with optional name search"""
        query = db.query(user_model.User)
        if search:
            query = query.filter(user_model.User.user_name.ilike(f"%{search}%"))
        return query.offset(skip).limit(limit).all()

    @staticmethod
    def get_user_by_identifier(db: Session, identifier: str):
        """Get user by email or phone"""
        user = db.query(user_model.User).filter(
            (user_model.User.email == identifier) | (user_model.User.phone == identifier)
        ).first()
        if not user:
            raise HTTPException(
                status_code=404,
                detail="Không tìm thấy người dùng với email hoặc số điện thoại này"
            )
        return user

    @staticmethod
    def get_user_by_email(db: Session, email: str):
        """Get user by email"""
        return db.query(user_model.User).filter(user_model.User.email == email).first()

    @staticmethod
    def get_user_by_phone(db: Session, phone: str):
        """Get user by phone"""
        return db.query(user_model.User).filter(user_model.User.phone == phone).first()

    @staticmethod
    def authenticate_user(db: Session, email: str, password: str):
        """Authenticate user with email and password"""
        user = UserService.get_user_by_email(db, email)
        if not user:
            return None
        if not UserService.verify_password(password, user.password):
            return None
        return user

    @staticmethod
    def verify_password(plain_password: str, password: str) -> bool:
        """Verify password"""
 
        return plain_password == password 

    @staticmethod
    def create_user(db: Session, user_data: dict):
        """Create new user"""
        if UserService.get_user_by_email(db, user_data["email"]):
            raise HTTPException(status_code=400, detail="Email đã được đăng ký")
        
        if UserService.get_user_by_phone(db, user_data["phone"]):
            raise HTTPException(status_code=400, detail="Số điện thoại đã được đăng ký")

        db_user = user_model.User(**user_data)
        
        db.add(db_user)
        db.commit()
        db.refresh(db_user)
        return db_user

    @staticmethod
    def update_user(db: Session, identifier: str, user_data: dict):
        """Update user by email or phone"""
        user = UserService.get_user_by_identifier(db, identifier)
        
        for key, value in user_data.items():
            if hasattr(user, key):
                setattr(user, key, value)
        
        db.commit()
        db.refresh(user)
        return user

    @staticmethod
    def delete_user(db: Session, identifier: str):
        """Delete user by email or phone"""
        user = UserService.get_user_by_identifier(db, identifier)
        
        if user.role == 1:
            raise HTTPException(status_code=400, detail="Không thể xóa tài khoản admin")
            
        db.delete(user)
        db.commit()
        return {"message": f"Đã xóa người dùng {user.user_name} thành công"}
