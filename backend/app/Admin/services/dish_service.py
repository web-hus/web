from datetime import datetime
from fastapi import HTTPException, status
from sqlalchemy.orm import Session
from typing import List, Optional

from ...models.tables import Dish
from ..schemas import dish_schema

class DishService:
    @staticmethod
    def create_dish(db: Session, dish: dish_schema.DishCreate) -> Dish:
        """Create a new dish based on the DishCreate schema."""
        db_dish = Dish(
            dish_id=dish.dish_id,
            dish_name=dish.dish_name,
            product_category=dish.product_category,
            price=dish.price,
            description=dish.description,
            availability=dish.availability,
            created_at=datetime.utcnow(),
        )
        db.add(db_dish)
        db.commit()
        db.refresh(db_dish)
        return db_dish

    @staticmethod
    def get_all_dishes(db: Session, skip: int = 0, limit: int = 100) -> List[Dish]:
        """Get all dishes"""
        return db.query(Dish).offset(skip).limit(limit).all()

    @staticmethod
    def get_dish(db: Session, dish_id: str) -> Optional[Dish]:
        """Get dish by ID"""
        return db.query(Dish).filter(Dish.dish_id == dish_id).first()

    @staticmethod
    def update_dish(db: Session, dish_id: str, dish: dish_schema.DishUpdate) -> Dish:
        """Update dish"""
        db_dish = DishService.get_dish(db, dish_id)
        if not db_dish:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Không tìm thấy món ăn"
            )

        update_data = dish.dict(exclude_unset=True)
        if "category_id" in update_data:
            update_data["product_category"] = update_data.pop("category_id")

        for key, value in update_data.items():
            setattr(db_dish, key, value)

        db_dish.updated_at = datetime.utcnow()
        db.commit()
        db.refresh(db_dish)
        return db_dish

    @staticmethod
    def delete_dish(db: Session, dish_id: str) -> Dish:
        """Delete dish"""
        db_dish = DishService.get_dish(db, dish_id)
        if not db_dish:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Không tìm thấy món ăn"
            )

        db.delete(db_dish)
        db.commit()
        return db_dish
