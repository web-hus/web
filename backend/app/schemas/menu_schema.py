from pydantic import BaseModel, Field, conint, confloat
from typing import List, Optional
from datetime import datetime

class MenuItem(BaseModel):
    dish_id: str = Field(..., pattern=r'^D\d{3}$')
    dish_name: str = Field(..., min_length=2, max_length=100)
    product_category: str = Field(..., min_length=2, max_length=50)
    price: confloat(gt=0)
    description: Optional[str] = None
    availability: conint(ge=0, le=1) = Field(default=1)

    class Config:
        from_attributes = True

class PriceRange(BaseModel):
    min_price: confloat(ge=0)
    max_price: confloat(gt=0)

    @property
    def validate_price_range(self):
        if self.max_price <= self.min_price:
            raise ValueError("max_price must be greater than min_price")
        return True

class MenuFilter(BaseModel):
    category: Optional[str] = Field(None, min_length=2, max_length=50)
    price_range: Optional[PriceRange] = None
    search_query: Optional[str] = Field(None, max_length=100)
