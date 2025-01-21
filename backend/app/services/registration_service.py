from sqlalchemy.orm import Session
from fastapi import HTTPException, status
from ..models.pending_user_model import PendingUser
from ..models.user_model import User
from ..schemas.registration_schema import UserRegistration
from datetime import datetime, timedelta
import secrets
import os
from dotenv import load_dotenv
from .email_service import EmailService

load_dotenv()

class RegistrationService:
    VERIFICATION_TOKEN_EXPIRE_MINUTES = 10
    SECRET_KEY = os.getenv('SECRET_KEY')
    ALGORITHM = os.getenv('ALGORITHM')
    FRONTEND_URL = os.getenv('FRONTEND_URL', 'http://localhost:3000')

    @staticmethod
    def generate_verification_token() -> str:
        """Generate a random verification token"""
        return secrets.token_urlsafe(32)

    @staticmethod
    def create_pending_user(db: Session, user_data: UserRegistration) -> PendingUser:
        """Create a pending user record"""
        # Check if email already exists in users table
        if db.query(User).filter(User.email == user_data.email).first():
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Email already registered"
            )

        # Check if phone already exists in users table
        if db.query(User).filter(User.phone == user_data.phone).first():
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Phone number already registered"
            )

        # Delete any existing pending registration for this email
        db.query(PendingUser).filter(PendingUser.email == user_data.email).delete()
        db.commit()

        # Create new pending user
        verification_token = RegistrationService.generate_verification_token()
        expires_at = datetime.utcnow() + timedelta(minutes=RegistrationService.VERIFICATION_TOKEN_EXPIRE_MINUTES)

        pending_user = PendingUser(
            name=user_data.user_name,
            age=user_data.age,
            gender=user_data.gender,
            address=user_data.address,
            email=user_data.email,
            phone=user_data.phone,
            password=user_data.password,
            verification_token=verification_token,
            expires_at=expires_at
        )

        try:
            db.add(pending_user)
            db.commit()
            db.refresh(pending_user)
            return pending_user
        except Exception as e:
            db.rollback()
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail=f"Error creating pending user: {str(e)}"
            )

    @staticmethod
    def verify_registration(db: Session, token: str) -> User:
        """Verify registration and create user"""
        # Find pending registration
        pending_user = db.query(PendingUser).filter(
            PendingUser.verification_token == token,
            PendingUser.expires_at > datetime.utcnow()
        ).first()

        if not pending_user:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Invalid or expired verification token"
            )

        try:
            # Create new user
            user = User(
                user_name=pending_user.name,
                age=pending_user.age,
                gender=pending_user.gender,
                address=pending_user.address,
                email=pending_user.email,
                phone=pending_user.phone,
                password=pending_user.password,
                role=0  # Regular user
            )

            db.add(user)
            
            # Delete pending registration
            db.delete(pending_user)
            
            db.commit()
            db.refresh(user)
            return user
            
        except Exception as e:
            db.rollback()
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail=f"Error creating user: {str(e)}"
            )

    @staticmethod
    def send_verification_email(email: str, verification_token: str):
        """Send verification email to user"""
        verification_link = f"{RegistrationService.FRONTEND_URL}/verify-registration?token={verification_token}"
        
        subject = "Xác nhận đăng ký tài khoản"
        body = f"""
        <html>
            <body>
                <h2>Xác nhận đăng ký tài khoản</h2>
                <p>Cảm ơn bạn đã đăng ký tài khoản. Vui lòng bấm vào đường link dưới đây để hoàn tất đăng ký:</p>
                <p><a href="{verification_link}">Xác nhận đăng ký</a></p>
                <p>Đường link sẽ hết hạn sau 10 phút.</p>
                <p>Nếu bạn không yêu cầu đăng ký tài khoản, vui lòng bỏ qua email này.</p>
            </body>
        </html>
        """

        EmailService.send_email(to_email=email, subject=subject, body=body)

    @staticmethod
    def cleanup_expired_registrations(db: Session):
        """Clean up expired pending registrations"""
        db.query(PendingUser).filter(
            PendingUser.expires_at <= datetime.utcnow()
        ).delete()
        db.commit()
