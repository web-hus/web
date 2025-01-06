# app//models.py
from sqlalchemy import Column, String, Integer, Float, Text, Boolean, DateTime
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()

class Dish(Base):
    __tablename__ = 'dish'
    
    dish_id = Column(String, primary_key=True)
    dish_name = Column(String, nullable=False)
    product_category = Column(String)
    price = Column(Float)
    description = Column(Text)
    created_at = Column(DateTime)
    availability = Column(Boolean)

    def __repr__(self):
        return f"<Dish(dish_id={self.dish_id}, dish_name={self.dish_name}, price={self.price})>"
