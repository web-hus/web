from pydantic import BaseModel, Field, ConfigDict
from typing import Optional
from datetime import datetime

class DishBase(BaseModel):
    dish_name: str
    product_category: str
    price: float = Field(..., gt=0)
    description: Optional[str] = None
    availability: int = Field(1, ge=0, le=1)  # 0: Hết hàng, 1: Còn hàng

class DishCreate(DishBase):
    dish_id: str = Field(..., pattern=r'^D\d{3}$')

class DishUpdate(BaseModel):
    dish_name: Optional[str] = None
    product_category: Optional[str] = None
    price: Optional[float] = Field(None, gt=0)
    description: Optional[str] = None
    availability: Optional[int] = Field(None, ge=0, le=1)

class Dish(DishBase):
    model_config = ConfigDict(from_attributes=True)

    dish_id: str = Field(..., pattern=r'^D\d{3}$')
    created_at: datetime
