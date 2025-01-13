from sqlalchemy.orm import Session
from datetime import datetime
from ..models import dish_model
from fastapi import HTTPException
from ..core.elasticsearch import get_elasticsearch, index_dish, update_dish_availability

class DishService:
    @staticmethod
    def get_dishes(db: Session, skip: int = 0, limit: int = 100, category: str = None):
        """Get list of dishes with optional category filter"""
        query = db.query(dish_model.Dish)
        if category:
            query = query.filter(dish_model.Dish.category == category)
        return query.offset(skip).limit(limit).all()

    @staticmethod
    def get_dish(db: Session, dish_id: str):
        """Get dish by ID"""
        dish = db.query(dish_model.Dish).filter(
            dish_model.Dish.dish_id == dish_id
        ).first()
        if not dish:
            raise HTTPException(status_code=404, detail="Không tìm thấy món ăn")
        return dish

    @staticmethod
    def create_dish(db: Session, dish_data: dict):
        """Create new dish"""
        if db.query(dish_model.Dish).filter(dish_model.Dish.dish_id == dish_data["dish_id"]).first():
            raise HTTPException(status_code=400, detail="Mã món ăn đã tồn tại")

        db_dish = dish_model.Dish(**dish_data)
        db.add(db_dish)
        db.commit()
        db.refresh(db_dish)

        # Index in Elasticsearch
        index_dish({
            "dish_id": db_dish.dish_id,
            "name": db_dish.name,
            "description": db_dish.description,
            "price": db_dish.price,
            "availability": db_dish.availability
        })

        return db_dish

    @staticmethod
    def check_dish_availability(db: Session, dish_id: str):
        """Check if dish is available"""
        dish = DishService.get_dish(db, dish_id)
        if not dish.availability:
            raise HTTPException(status_code=400, detail="Món ăn hiện đã hết")
        return dish

    @staticmethod
    def update_dish_availability(db: Session, dish_id: str, change: int):
        """Update dish availability in database and Elasticsearch"""
        dish = DishService.get_dish(db, dish_id)
        
        # Update in database
        dish.availability = bool(change > 0)
        dish.updated_at = datetime.utcnow()
        db.commit()
        db.refresh(dish)

        # Update in Elasticsearch
        update_dish_availability(dish_id, int(dish.availability))
