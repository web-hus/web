# app/routers/dish.py (backend FastAPI)
from fastapi import APIRouter, HTTPException, Depends
from app.models import Dish
from sqlalchemy.orm import Session
from app.database import SessionLocal
from app.database import get_db
import uuid
from pydantic import BaseModel
from typing import Optional

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

# # Schema để validate dữ liệu món ăn
# class DishCreate(BaseModel):
#     dish_name: str
#     product_category: str
#     price: float
#     description: str
#     availability: int

# class DishUpdate(BaseModel):
#     dish_name: Optional[str] = None
#     product_category: Optional[str] = None
#     price: Optional[float] = None
#     description: Optional[str] = None
#     availability: Optional[int] = None

# # Thêm món ăn mới
# @router.post("/dishes", response_model=dict)
# async def create_dish(dish: DishCreate, db: Session = Depends(get_db)):
#     new_dish = Dish(
#         dish_id=str(uuid.uuid4()),  # Tạo UUID cho dish_id
#         dish_name=dish.dish_name,
#         product_category=dish.product_category,
#         price=dish.price,
#         description=dish.description,
#         availability=dish.availability,
#     )
#     db.add(new_dish)
#     db.commit()
#     db.refresh(new_dish)
#     return {"message": "Dish created successfully", "dish": new_dish}

# # Chỉnh sửa món ăn
# @router.put("/dishes/{id}", response_model=dict)
# async def update_dish(id: str, updated_dish: DishUpdate, db: Session = Depends(get_db)):
#     dish = db.query(Dish).filter(Dish.dish_id == id).first()
#     if not dish:
#         raise HTTPException(status_code=404, detail="Dish not found")

#     dish.dish_name = updated_dish.dish_name
#     dish.product_category = updated_dish.product_category
#     dish.price = updated_dish.price
#     dish.description = updated_dish.description
#     dish.availability = updated_dish.availability

#     db.commit()
#     db.refresh(dish)
#     return {"message": "Dish updated successfully", "dish": dish}

# # Xóa món ăn
# @router.delete("/dishes/{id}", response_model=dict)
# async def delete_dish(id: str, db: Session = Depends(get_db)):
#     dish = db.query(Dish).filter(Dish.dish_id == id).first()
#     if not dish:
#         raise HTTPException(status_code=404, detail="Dish not found")
    
#     db.delete(dish)
#     db.commit()
#     return {"message": "Dish deleted successfully"}