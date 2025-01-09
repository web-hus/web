# app//models.py
from sqlalchemy import Column, String, Integer, Float, Text, Boolean, DateTime
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import func

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

class User(Base):
    __tablename__ = 'users'
    
    user_id = Column(Integer, primary_key=True, autoincrement=True)
    user_name = Column(String(255), nullable=False)
    age = Column(Integer, nullable=False)
    gender = Column(String(1), nullable=False)
    address = Column(Text, nullable=False)
    email = Column(String(255), unique=True, nullable=False)
    phone = Column(String(15), unique=True, nullable=False)
    created_at = Column(DateTime, default=func.now())  # Set default for created_at
    updated_at = Column(DateTime, default=func.now(), onupdate=func.now())  # Auto update the timestamp
    password = Column(Text, nullable=False)  # Will store the hashed password
    role = Column(Integer, nullable=False, default=0)  # 0: Customer, 1: Admin
    
    def __repr__(self):
        return f"<User(user_id={self.user_id}, user_name={self.user_name}, age={self.age}, gender={self.gender}, address={self.address}, phone={self.phone}, email={self.email})>"
