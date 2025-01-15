from sqlalchemy.orm import Session
from datetime import datetime
from ..models.dish_model import Dish
from fastapi import HTTPException, status
from ..schemas.dish_schema import DishCreate, DishUpdate
from sqlalchemy.exc import IntegrityError
import logging

logger = logging.getLogger(__name__)

class DishService:
    @staticmethod
    def get_dishes(db: Session, skip: int = 0, limit: int = 100, search: str = None):
        """Get list of dishes with optional name search"""
        query = db.query(Dish)
        if search:
            query = query.filter(Dish.dish_name.ilike(f"%{search}%"))
        return query.offset(skip).limit(limit).all()

    @staticmethod
    def get_dish_by_id(db: Session, dish_id: str) -> Dish:
        """Get dish by ID"""
        return db.query(Dish).filter(Dish.dish_id == dish_id).first()

    @staticmethod
    def get_dish_by_name(db: Session, dish_name: str) -> Dish:
        """Get dish by name"""
        dish = db.query(Dish).filter(Dish.dish_name == dish_name).first()
        if not dish:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Không tìm thấy món ăn"
            )
        return dish

    @staticmethod
    def create_dish(db: Session, dish_data: DishCreate) -> Dish:
        """Create new dish"""
        try:
            # Check if dish name already exists
            existing_dish = db.query(Dish).filter(Dish.dish_name == dish_data.dish_name).first()
            if existing_dish:
                raise HTTPException(
                    status_code=status.HTTP_400_BAD_REQUEST,
                    detail="Tên món ăn đã tồn tại"
                )

            # Create new dish
            db_dish = Dish(
                dish_id=dish_data.dish_id,
                dish_name=dish_data.dish_name,
                product_category=dish_data.product_category,
                price=dish_data.price,
                description=dish_data.description,
                availability=dish_data.availability,
                created_at=datetime.utcnow()
            )
            
            db.add(db_dish)
            db.commit()
            db.refresh(db_dish)
            return db_dish
            
        except IntegrityError as e:
            db.rollback()
            logger.error(f"Database integrity error in create_dish: {str(e)}")
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail=f"Database integrity error: {str(e)}"
            )
        except HTTPException:
            db.rollback()
            raise
        except Exception as e:
            db.rollback()
            logger.error(f"Unexpected error in create_dish: {str(e)}")
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail="Internal server error while creating dish"
            )

    @staticmethod
    def update_dish(db: Session, dish_id: str, dish_data: DishUpdate) -> Dish:
        """Update dish information by ID"""
        try:
            dish = DishService.get_dish_by_id(db, dish_id)
            
            # If updating dish_name, check if new name already exists
            if "dish_name" in dish_data and dish_data.dish_name != dish.dish_name:
                existing_dish = db.query(Dish).filter(Dish.dish_name == dish_data.dish_name).first()
                if existing_dish:
                    raise HTTPException(
                        status_code=status.HTTP_400_BAD_REQUEST,
                        detail="Tên món ăn mới đã tồn tại"
                    )
            
            for key, value in dish_data.items():
                setattr(dish, key, value)
            
            dish.updated_at = datetime.utcnow()
            db.commit()
            db.refresh(dish)
            return dish
            
        except IntegrityError as e:
            db.rollback()
            logger.error(f"Database integrity error in update_dish: {str(e)}")
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail=f"Database integrity error: {str(e)}"
            )
        except HTTPException:
            db.rollback()
            raise
        except Exception as e:
            db.rollback()
            logger.error(f"Unexpected error in update_dish: {str(e)}")
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail="Internal server error while updating dish"
            )

    @staticmethod
    def delete_dish(db: Session, dish_id: str):
        """Delete dish by ID"""
        try:
            dish = DishService.get_dish_by_id(db, dish_id)
            
            db.delete(dish)
            db.commit()
            return {"message": f"Đã xóa món ăn '{dish.dish_name}' thành công"}
            
        except IntegrityError as e:
            db.rollback()
            logger.error(f"Database integrity error in delete_dish: {str(e)}")
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail=f"Database integrity error: {str(e)}"
            )
        except HTTPException:
            db.rollback()
            raise
        except Exception as e:
            db.rollback()
            logger.error(f"Unexpected error in delete_dish: {str(e)}")
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail="Internal server error while deleting dish"
            )
