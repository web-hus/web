from sqlalchemy.orm import Session
from datetime import datetime
from ...models import dish_model
from ..schemas import dish_schema
from fastapi import HTTPException
from ...core.elasticsearch import get_elasticsearch, index_dish, update_dish_availability

class DishService:
    @staticmethod
    def get_dishes(db: Session, skip: int = 0, limit: int = 100, category: str = None):
        """Get list of dishes with optional category filter"""
        query = db.query(dish_model.Dish)
        if category:
            query = query.filter(dish_model.Dish.category == category)
        return query.offset(skip).limit(limit).all()

    @staticmethod
    def create_dish(db: Session, dish: dish_schema.DishCreate):
        """Create new dish"""
        # Check if dish_id exists
        if db.query(dish_model.Dish).filter(dish_model.Dish.dish_id == dish.dish_id).first():
            raise HTTPException(status_code=400, detail="Mã món ăn đã tồn tại")

        db_dish = dish_model.Dish(
            dish_id=dish.dish_id,
            name=dish.name,
            description=dish.description,
            price=dish.price,
            category=dish.category,
            image_url=dish.image_url,
            availability=dish.availability,
            created_at=datetime.utcnow(),
            updated_at=datetime.utcnow()
        )
        db.add(db_dish)
        db.commit()
        db.refresh(db_dish)

        # Index dish in Elasticsearch
        index_dish({
            "dish_id": db_dish.dish_id,
            "name": db_dish.name,
            "description": db_dish.description,
            "price": db_dish.price,
            "availability": db_dish.availability
        })

        return db_dish

    @staticmethod
    def update_dish(db: Session, dish_id: str, dish: dish_schema.DishUpdate):
        """Update dish information"""
        db_dish = db.query(dish_model.Dish).filter(
            dish_model.Dish.dish_id == dish_id
        ).first()
        if not db_dish:
            raise HTTPException(status_code=404, detail="Không tìm thấy món ăn")

        # Update fields
        for var, value in vars(dish).items():
            if value is not None:
                setattr(db_dish, var, value)

        db_dish.updated_at = datetime.utcnow()
        db.commit()
        db.refresh(db_dish)

        # Update Elasticsearch
        if dish.availability is not None:
            update_dish_availability(dish_id, dish.availability)

        return db_dish

    @staticmethod
    def delete_dish(db: Session, dish_id: str):
        """Delete dish"""
        db_dish = db.query(dish_model.Dish).filter(
            dish_model.Dish.dish_id == dish_id
        ).first()
        if not db_dish:
            raise HTTPException(status_code=404, detail="Không tìm thấy món ăn")

        # Check if dish is in any orders
        if db.query(order_model.OrderDish).filter(
            order_model.OrderDish.dish_id == dish_id
        ).first():
            raise HTTPException(
                status_code=400, 
                detail="Không thể xóa món ăn đã có trong đơn hàng"
            )

        db.delete(db_dish)
        db.commit()

        # Remove from Elasticsearch
        es = get_elasticsearch()
        es.delete(index="dishes", id=dish_id, ignore=[404])

        return {"message": "Đã xóa món ăn thành công"}
