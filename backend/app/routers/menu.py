from fastapi import APIRouter, Depends, Query
from sqlalchemy.orm import Session
from typing import List, Optional
from ..database import get_db
from ..services.menu_service import MenuService
from ..schemas.menu_schema import MenuItem, MenuFilter

router = APIRouter(
    prefix="/menu",
    tags=["menu"]
)

@router.get("/categories", response_model=List[str])
def get_categories(db: Session = Depends(get_db)):
    """Get all product categories"""
    return MenuService.get_categories(db)

@router.get("/items", response_model=List[MenuItem])
def get_menu_items(
    category: Optional[str] = None,
    min_price: Optional[float] = None,
    max_price: Optional[float] = None,
    search: Optional[str] = None,
    skip: int = Query(0, ge=0),
    limit: int = Query(100, ge=1),
    db: Session = Depends(get_db)
):
    """
    Get menu items with filters:
    - By category
    - By price range
    - By search query
    """
    return MenuService.get_menu_items(
        db=db,
        category=category,
        min_price=min_price,
        max_price=max_price,
        search_query=search,
        skip=skip,
        limit=limit
    )

@router.get("/price-ranges")
def get_price_ranges():
    """Get predefined price ranges for filtering"""
    return MenuService.get_price_ranges()
