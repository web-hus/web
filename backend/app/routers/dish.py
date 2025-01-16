# app/routers/dish.py (backend FastAPI)
from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from ..database import get_db
from ..models.dish_model import Dish

router = APIRouter()

# Lấy tất cả món ăn
@router.get("/dishes")
async def get_dishes(db: Session = Depends(get_db)):
    """Get all dishes"""
    try:
        dishes = db.query(Dish).all()
        return dishes
    except Exception as e:
        raise HTTPException(
            status_code=500,
            detail=f"Error getting dishes: {str(e)}"
        )

# Lấy món ăn theo ID
@router.get("/dishes/{id}")
async def get_dish_by_id(
    id: str,
    db: Session = Depends(get_db)
):
    """Get dish by ID"""
    try:
        dish = db.query(Dish).filter(Dish.dish_id == id).first()
        if not dish:
            raise HTTPException(
                status_code=404,
                detail="Dish not found"
            )
        return dish
    except Exception as e:
        if isinstance(e, HTTPException):
            raise e
        raise HTTPException(
            status_code=500,
            detail=f"Error getting dish: {str(e)}"
        )