import redis
from fastapi import HTTPException, status
import random
import os
from dotenv import load_dotenv

load_dotenv()

# Redis connection
redis_client = redis.Redis(
    host=os.getenv('REDIS_HOST', 'localhost'),
    port=int(os.getenv('REDIS_PORT', 6379)),
    db=0,
    decode_responses=True
)

class RedisService:
    OTP_EXPIRE_TIME = 360  # 6 minutes in seconds
    
    @staticmethod
    def generate_otp() -> str:
        """Generate a 6-digit OTP"""
        return ''.join([str(random.randint(0, 9)) for _ in range(6)])
    
    @staticmethod
    def save_otp(email: str, otp: str) -> None:
        """Save OTP to Redis with expiration"""
        try:
            # Key format: otp:{email}
            redis_client.setex(f"otp:{email}", RedisService.OTP_EXPIRE_TIME, otp)
            # Also save email to track which email requested OTP
            redis_client.setex(f"reset_email:{email}", RedisService.OTP_EXPIRE_TIME, "1")
        except redis.RedisError as e:
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail="Error saving OTP"
            )
    
    @staticmethod
    def verify_otp(email: str, otp: str) -> bool:
        """Verify if OTP is valid and not expired"""
        try:
            stored_otp = redis_client.get(f"otp:{email}")
            if stored_otp and stored_otp == otp:
                # Delete OTP after successful verification but keep email tracking
                redis_client.delete(f"otp:{email}")
                return True
            return False
        except redis.RedisError as e:
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail="Error verifying OTP"
            )
    
    @staticmethod
    def can_reset_password(email: str) -> bool:
        """Check if email has requested password reset"""
        try:
            return bool(redis_client.get(f"reset_email:{email}"))
        except redis.RedisError as e:
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail="Error checking reset permission"
            )
    
    @staticmethod
    def clear_reset_permission(email: str) -> None:
        """Clear reset permission after password reset"""
        try:
            redis_client.delete(f"reset_email:{email}")
        except redis.RedisError:
            pass  # Ignore errors when clearing
