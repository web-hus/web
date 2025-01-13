from fastapi import APIRouter, Depends, HTTPException, status
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy.orm import Session
from ..database import get_db
from ..services.user_service import UserService
from ..auth.auth_handler import signJWT

router = APIRouter(
    prefix="/auth",
    tags=["auth"]
)

@router.post("/token")
async def login(
    form_data: OAuth2PasswordRequestForm = Depends(),
    db: Session = Depends(get_db)
):
    """
    Login endpoint to get JWT token
    - username: email của user
    - password: mật khẩu
    """
    user = UserService.authenticate_user(db, form_data.username, form_data.password)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Email hoặc mật khẩu không chính xác",
            headers={"WWW-Authenticate": "Bearer"},
        )
    
    token = signJWT(str(user.user_id), user.role)
    return {
        **token,
        "user_id": user.user_id,
        "role": user.role
    }
