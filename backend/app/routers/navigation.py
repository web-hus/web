from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from ..database import get_db
from ..services.navigation_service import NavigationService
from ..auth.auth_bearer import JWTBearer

router = APIRouter(
    prefix="/navigation",
    tags=["navigation"],
    dependencies=[Depends(JWTBearer())]
)
