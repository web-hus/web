from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from ..database import get_db
from ..schemas.password_schema import (
    ResetPasswordRequest,
    ForgotPasswordRequest,
    VerifyOTPRequest
)
from ..services.password_service import PasswordService

router = APIRouter(
    prefix="/password",
    tags=["password"]
)

@router.post("/reset")
async def reset_password(
    request: ResetPasswordRequest,
    db: Session = Depends(get_db)
):
    """Reset password with new password"""
    if not request.passwords_match():
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Passwords do not match"
        )
    
    PasswordService.reset_password(
        db=db,
        email=request.email,
        new_password=request.new_password
    )
    
    return {"message": "Password reset successfully"}

@router.post("/forgot")
async def forgot_password(request: ForgotPasswordRequest):
    """Initiate forgot password process by sending OTP"""
    PasswordService.initiate_forgot_password(request.email)
    return {
        "message": "If an account exists with this email, an OTP has been sent",
        "expires_in": "6 minutes"
    }

@router.post("/verify-otp")
async def verify_otp(
    request: VerifyOTPRequest,
    db: Session = Depends(get_db)
):
    """Verify OTP for password reset"""
    is_valid = PasswordService.verify_otp(request.email, request.otp)
    if not is_valid:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Invalid or expired OTP"
        )
    
    return {"message": "OTP verified successfully"}
