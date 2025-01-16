from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from .. import crud, models, database
from ..schemas.user_schema import UserCreate, User
from ..auth.auth_bearer import JWTBearer
from ..auth.auth_handler import get_current_user

router = APIRouter()

# Thêm người dùng mới
@router.post("/users", response_model=User)
def create_user(user: UserCreate, db: Session = Depends(database.get_db)):
    """Create new user"""
    try:
        return crud.create_user(db, user)
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Error creating user: {str(e)}"
        )
