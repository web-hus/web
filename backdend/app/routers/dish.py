# app/routers/dish.py (backend FastAPI)
from fastapi import APIRouter, HTTPException
from app.models import Dish
from sqlalchemy.orm import Session
from app.database import SessionLocal

router = APIRouter()

# Lấy tất cả món ăn
@router.get("/dishes")
async def get_dishes():
    db: Session = SessionLocal()
    dishes = db.query(Dish).all()  # Lấy tất cả món ăn từ DB
    db.close()
    return dishes

# Lấy món ăn theo ID
@router.get("/dishes/{id}")
async def get_dish_by_id(id: str):
    db: Session = SessionLocal()
    dish = db.query(Dish).filter(Dish.dish_id == id).first() 
    db.close()
    
    if not dish:
        raise HTTPException(status_code=404, detail="Dish not found")
    
    return dish