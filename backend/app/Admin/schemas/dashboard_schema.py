from pydantic import BaseModel
from typing import List
from datetime import date, datetime

class OrderStats(BaseModel):
    total_orders: int
    total_revenue: float
    daily_revenue: List[dict]  # [{date: str, revenue: float}]
    customer_ratio: dict  # {offline: float, online: float}

class TopDish(BaseModel):
    dish_id: str
    name: str
    order_count: int
    total_revenue: float

class DashboardStats(BaseModel):
    monthly_orders: int
    total_revenue: float
    top_dishes: List[TopDish]
    daily_revenue: List[dict]
    customer_ratio: dict
    current_month: str
