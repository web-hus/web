# from pydantic import BaseModel, Field
# from typing import Optional
# from datetime import datetime

# class DishBase(BaseModel):
#     name: str = Field(..., min_length=1, max_length=100)
#     description: str = Field(..., min_length=1)
#     price: float = Field(..., gt=0)
#     image_url: str = Field(..., pattern=r'^https?://\S+$')  # URL validation
#     category_id: int = Field(...)  # This will be mapped to product_category in the database
#     is_available: bool = Field(default=True)  # This will be mapped to availability in the database

# class DishCreate(DishBase):
#     pass

# class DishUpdate(BaseModel):
#     name: Optional[str] = Field(None, min_length=1, max_length=100)
#     description: Optional[str] = Field(None, min_length=1)
#     price: Optional[float] = Field(None, gt=0)
#     image_url: Optional[str] = Field(None, pattern=r'^https?://\S+$')
#     category_id: Optional[int] = None  # This will be mapped to product_category in the database
#     is_available: Optional[bool] = None  # This will be mapped to availability in the database

# class Dish(DishBase):
#     model_config = {
#         "from_attributes": True
#     }
    
#     dish_id: int
#     created_at: datetime
#     updated_at: datetime
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
