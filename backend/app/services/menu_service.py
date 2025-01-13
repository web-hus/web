from sqlalchemy.orm import Session
from sqlalchemy import and_
from ..models import dish_model
from ..schemas import menu_schema
from typing import List, Optional

class MenuService:
    @staticmethod
    def get_categories(db: Session) -> List[str]:
        """Get all unique product categories"""
        return db.query(dish_model.Dish.product_category)\
                .distinct()\
                .all()

    @staticmethod
    def get_menu_items(
        db: Session,
        category: Optional[str] = None,
        min_price: Optional[float] = None,
        max_price: Optional[float] = None,
        search_query: Optional[str] = None,
        skip: int = 0,
        limit: int = 100
    ) -> List[dish_model.Dish]:
        """
        Get menu items with filters:
        - By category
        - By price range
        - By search query
        """
        query = db.query(dish_model.Dish).filter(dish_model.Dish.availability == 1)

        # Apply category filter
        if category:
            query = query.filter(dish_model.Dish.product_category == category)

        # Apply price range filter
        if min_price is not None:
            query = query.filter(dish_model.Dish.price >= min_price)
        if max_price is not None:
            query = query.filter(dish_model.Dish.price <= max_price)

        # Apply search filter
        if search_query:
            search = f"%{search_query}%"
            query = query.filter(
                dish_model.Dish.dish_name.ilike(search) |
                dish_model.Dish.description.ilike(search)
            )

        # Return paginated results
        return query.offset(skip).limit(limit).all()

    @staticmethod
    def get_price_ranges() -> List[dict]:
        """Get predefined price ranges"""
        return [
            {"min": 0, "max": 50000, "label": "Dưới 50,000 VND"},
            {"min": 50000, "max": 99000, "label": "Từ 50,000 - 99,000 VND"},
            {"min": 100000, "max": 199000, "label": "Từ 100,000 - 199,000 VND"},
            {"min": 200000, "max": None, "label": "Trên 200,000 VND"}
        ]
