from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from ..database import get_db
from ..services.navigation_service import NavigationService
from ..schemas.navigation_schema import Navigation, NavigationItem
from typing import List
from ..auth.auth_bearer import JWTBearer
from ..auth.auth_handler import decodeJWT

router = APIRouter(
    prefix="/navigation",
    tags=["navigation"]
)

@router.get("/", response_model=Navigation)
async def get_navigation(
    db: Session = Depends(get_db),
    token: str = Depends(JWTBearer())
):
    """Get all navigation items based on user role"""
    payload = decodeJWT(token)
    is_admin = payload.get("role") == 1

    nav = Navigation(
        main_nav=NavigationService.get_main_navigation(),
        user_nav=NavigationService.get_user_navigation(),
        admin_nav=NavigationService.get_admin_navigation() if is_admin else []
    )
    return nav

@router.get("/categories", response_model=List[NavigationItem])
async def get_category_navigation(db: Session = Depends(get_db)):
    """Get category navigation items"""
    return NavigationService.get_category_navigation(db)
