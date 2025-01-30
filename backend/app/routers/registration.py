from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from ..database import get_db
from ..schemas.registration_schema import UserRegistration, VerifyRegistration
from ..services.registration_service import RegistrationService
from ..services.cart_service import CartService
from .. schemas.cart_schema import CartCreate
router = APIRouter(
    prefix="/registration",
    tags=["registration"]
)

@router.post("/register")
async def register_user(
    user_data: UserRegistration,
    db: Session = Depends(get_db)
):
    """
    Register a new user
    - Creates a pending registration
    - Sends verification email
    - Returns success message
    """
    try:
        # Create pending registration
        pending_user = RegistrationService.create_pending_user(db, user_data)

        # Send verification email
        RegistrationService.send_verification_email(
            pending_user.email,
            pending_user.verification_token
        )

        return {
            "message": "Registration initiated. Please check your email for verification link",
            "expires_in": "10 minutes"
        }

    except Exception as e:
        if isinstance(e, HTTPException):
            raise e
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Error during registration: {str(e)}"
        )

@router.post("/verify")
async def verify_registration(
    verification_data: VerifyRegistration,
    db: Session = Depends(get_db)
):
    """
    Verify user registration
    - Validates verification token
    - Creates user account
    - Deletes pending registration
    - Returns success message
    """
    try:
        # Clean up expired registrations
        RegistrationService.cleanup_expired_registrations(db)

        # Verify and create user
        user = RegistrationService.verify_registration(
            db,
            verification_data.token
        )

        cart = CartService.create_cart(db=db, cart_data=CartCreate(user_id=user.user_id))

        return {
            "message": "Đăng ký thành công! Vui lòng đăng nhập.",
            "user_id": user.user_id,
            "cart_id": cart.cart_id,
        }

    except Exception as e:
        if isinstance(e, HTTPException):
            raise e
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Error during verification: {str(e)}"
        )
