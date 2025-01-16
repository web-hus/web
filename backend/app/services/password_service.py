from sqlalchemy.orm import Session
from fastapi import HTTPException, status
from ..models.user_model import User
from .email_service import EmailService
from datetime import datetime, timedelta
import jwt
import os
from dotenv import load_dotenv

load_dotenv()

class PasswordService:
    RESET_TOKEN_EXPIRE_MINUTES = 6
    SECRET_KEY = os.getenv('SECRET_KEY')
    ALGORITHM = os.getenv('ALGORITHM')
    FRONTEND_URL = os.getenv('FRONTEND_URL', 'http://localhost:3000')

    @staticmethod
    def generate_reset_token(email: str) -> str:
        """Generate a JWT token for password reset"""
        expires_at = datetime.utcnow() + timedelta(minutes=PasswordService.RESET_TOKEN_EXPIRE_MINUTES)
        
        token_data = {
            "sub": email,
            "exp": expires_at
        }
        
        return jwt.encode(
            token_data,
            PasswordService.SECRET_KEY,
            algorithm=PasswordService.ALGORITHM
        )

    @staticmethod
    def verify_reset_token(token: str) -> str:
        """Verify reset token and return email if valid"""
        try:
            payload = jwt.decode(
                token,
                PasswordService.SECRET_KEY,
                algorithms=[PasswordService.ALGORITHM]
            )
            email = payload.get("sub")
            if email is None:
                raise HTTPException(
                    status_code=status.HTTP_400_BAD_REQUEST,
                    detail="Invalid reset token"
                )
            return email
        except jwt.ExpiredSignatureError:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Reset token has expired"
            )
        except jwt.JWTError:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Invalid reset token"
            )

    @staticmethod
    def reset_password(db: Session, token: str, new_password: str) -> None:
        """Reset user's password using reset token"""
        # Verify token and get email
        email = PasswordService.verify_reset_token(token)
        
        # Find user by email
        user = db.query(User).filter(User.email == email).first()
        if not user:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="User not found"
            )

        # Update password
        user.password = new_password
        
        try:
            db.commit()
        except Exception as e:
            db.rollback()
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail="Error resetting password"
            )

    @staticmethod
    def initiate_forgot_password(db: Session, email: str) -> None:
        """Send reset link for password reset"""
        # Check if user exists
        user = db.query(User).filter(User.email == email).first()
        if not user:
            # Don't reveal if user exists, just return success
            return
        
        # Generate reset token
        reset_token = PasswordService.generate_reset_token(email)
        
        # Generate reset link
        reset_link = f"{PasswordService.FRONTEND_URL}/reset-password?token={reset_token}"
        
        # Send reset link via email
        EmailService.send_reset_link_email(email, reset_link)
