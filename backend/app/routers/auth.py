from fastapi import APIRouter, Depends, HTTPException, status
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy.orm import Session
from ..database import get_db
from ..services.user_service import UserService
from ..auth.auth_handler import create_access_token

router = APIRouter(
    prefix="/auth",
    tags=["auth"]
)

@router.post("/login", 
    summary="User Login",
    description="""
    Authenticate user and return access token.
    
    **Input:**
    - username: Email or phone number
    - password: User's password
    
    **Returns:**
    - access_token: JWT token for authentication
    - token_type: Type of token (bearer)
    - user_id: User's ID
    - role: User's role
    """)
async def login(
    form_data: OAuth2PasswordRequestForm = Depends(),
    db: Session = Depends(get_db)
):
    try:
        # Xác thực user
        user = UserService.authenticate_user(
            db, 
            form_data.username, 
            form_data.password
        )
        
        if not user:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Username hoặc password không đúng"
            )
            
        # Tạo token với thông tin user
        token_data = {
            "user_id": user.user_id,
            "role": user.role
        }
        
        access_token = create_access_token(token_data)
        
        return {
            "access_token": access_token,
            "token_type": "bearer",
            "user_id": user.user_id,
            "role": user.role
        }
        
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=str(e)
        )