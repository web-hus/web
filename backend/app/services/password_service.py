from sqlalchemy.orm import Session
from fastapi import HTTPException, status
from ..models.user_model import User
from .redis_service import RedisService
from .email_service import EmailService

class PasswordService:
    @staticmethod
    def reset_password(db: Session, email: str, new_password: str) -> None:
        """Reset user's password"""
        # Check if email has permission to reset password
        if not RedisService.can_reset_password(email):
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="Please request OTP first"
            )

        # Find user by email
        user = db.query(User).filter(User.email == email).first()
        if not user:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="User not found"
            )


        user.password = new_password
        
        try:
            db.commit()
            # Clear reset permission after successful password reset
            RedisService.clear_reset_permission(email)
        except Exception as e:
            db.rollback()
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail="Error resetting password"
            )

    @staticmethod
    def initiate_forgot_password(email: str) -> None:
        """Send OTP for password reset"""
        # Generate OTP
        otp = RedisService.generate_otp()
        
        # Save OTP to Redis
        RedisService.save_otp(email, otp)
        
        # Send OTP via email
        EmailService.send_otp_email(email, otp)

    @staticmethod
    def verify_otp(email: str, otp: str) -> bool:
        """Verify OTP for password reset"""
        return RedisService.verify_otp(email, otp)
