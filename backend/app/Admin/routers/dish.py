from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from ...database import get_db
from ..services.dish_service import DishService
from ..schemas import dish_schema
from ...auth.auth_bearer import JWTBearer
from ...auth.auth_handler import decodeJWT
from typing import List, Optional

router = APIRouter(
    prefix="/admin/dishes",
    tags=["admin-dishes"],
    dependencies=[Depends(JWTBearer())]
)

def check_admin(token: str = Depends(JWTBearer())):
    user_data = decodeJWT(token)
    if user_data.get("role") != 1:
        raise HTTPException(status_code=403, detail="Cần quyền truy cập của Admin")
    return user_data

def get_current_user(token: str = Depends(JWTBearer())):
    return decodeJWT(token)

@router.get("/", response_model=List[dish_schema.Dish])
def get_dishes( 
    skip: int = 0,
    limit: int = 100,
    category: Optional[str] = None,
    db: Session = Depends(get_db),
    user: dict = Depends(get_current_user)
):
    """Get list of dishes with optional category filter"""
    return DishService.get_dishes(db, skip=skip, limit=limit, category=category)

@router.post("/", response_model=dish_schema.Dish)
def create_dish(
    dish: dish_schema.DishCreate,
    db: Session = Depends(get_db),
    admin: dict = Depends(check_admin)
):
    """Create new dish"""
    return DishService.create_dish(db, dish)

@router.put("/{dish_id}", response_model=dish_schema.Dish)
def update_dish(
    dish_id: str,
    dish: dish_schema.DishUpdate,
    db: Session = Depends(get_db),
    admin: dict = Depends(check_admin)
):
    """Update dish information"""
    return DishService.update_dish(db, dish_id, dish)

@router.delete("/{dish_id}")
def delete_dish(
    dish_id: str,
    db: Session = Depends(get_db),
    admin: dict = Depends(check_admin)
):
    """Delete dish"""
    return DishService.delete_dish(db, dish_id)
