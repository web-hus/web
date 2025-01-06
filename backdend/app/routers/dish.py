# app/routers/dish.py (backend FastAPI)
from fastapi import APIRouter
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
