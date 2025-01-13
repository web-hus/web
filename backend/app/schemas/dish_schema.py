from pydantic import BaseModel, Field, conint, confloat
from typing import Optional
from datetime import datetime

class DishBase(BaseModel):
    dish_name: str = Field(..., min_length=2, max_length=100)
    product_category: str = Field(..., min_length=2, max_length=50)
    price: confloat(gt=0) = Field(..., description="Price must be greater than 0")
    description: Optional[str] = Field(None, max_length=500)
    availability: conint(ge=0, le=1) = Field(default=1)

class DishCreate(DishBase):
    dish_id: str = Field(..., pattern=r'^D\d{3}$')

class DishUpdate(BaseModel):
    dish_name: Optional[str] = Field(None, min_length=2, max_length=100)
    product_category: Optional[str] = Field(None, min_length=2, max_length=50)
    price: Optional[confloat(gt=0)] = Field(None, description="Price must be greater than 0")
    description: Optional[str] = Field(None, max_length=500)
    availability: Optional[conint(ge=0, le=1)] = None

class Dish(DishBase):
    dish_id: str = Field(..., pattern=r'^D\d{3}$')
    created_at: datetime = Field(default_factory=datetime.now)

    class Config:
        from_attributes = True
