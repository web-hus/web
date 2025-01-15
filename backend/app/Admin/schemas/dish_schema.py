from pydantic import BaseModel, Field
from typing import Optional
from datetime import datetime

class DishBase(BaseModel):
    name: str
    description: Optional[str] = None
    price: float = Field(..., gt=0)
    category: str
    image_url: Optional[str] = None
    availability: int = Field(1, ge=0, le=1)

class DishCreate(DishBase):
    dish_id: str = Field(..., regex=r'^D\d{3}$')

class DishUpdate(DishBase):
    pass

class Dish(DishBase):
    dish_id: str
    created_at: datetime
    updated_at: datetime

    class Config:
        orm_mode = True
