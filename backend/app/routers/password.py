from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from ..database import get_db
from ..schemas.password_schema import (
    ResetPasswordRequest,
    ForgotPasswordRequest
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
        token=request.token,
        new_password=request.new_password
    )
    
    return {"message": "Password reset successfully"}

@router.post("/forgot")
async def forgot_password(
    request: ForgotPasswordRequest,
    db: Session = Depends(get_db)
):
    """Send reset link to user's email"""
    PasswordService.initiate_forgot_password(db, request.email)
    return {
        "message": "If an account exists with this email, a password reset link has been sent",
        "expires_in": "6 minutes"
    }
