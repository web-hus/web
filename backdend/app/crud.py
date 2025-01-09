from sqlalchemy.orm import Session
from . import models
from . import database

def create_database():
    return models.Base.metadata.create_all(bind=database.engine)
# Lấy tất cả các món ăn
def get_dishes(db: Session, skip: int = 0, limit: int = 100):
    return db.query(models.Dish).offset(skip).limit(limit).all()

# Thêm món ăn mới
def create_dish(db: Session, name: str, price: int):
    db_dish = models.Dish(name=name, price=price)
    db.add(db_dish)
    db.commit()
    db.refresh(db_dish)
    return db_dish

# Lấy tất cả người dùng
def get_users(db: Session, skip: int = 0, limit: int = 100):
    return db.query(models.User).offset(skip).limit(limit).all()

# # Thêm người dùng mới
# def create_user(db: Session, name: str, email: str, phone: str):
#     db_user = models.User(name=name, email=email, phone=phone)
#     db.add(db_user)
#     db.commit()
#     db.refresh(db_user)
#     return db_user
