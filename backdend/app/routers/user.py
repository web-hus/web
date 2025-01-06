from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from .. import crud, models, database

router = APIRouter()

# Lấy danh sách người dùng
@router.get("/users")
def get_users(skip: int = 0, limit: int = 100, db: Session = Depends(database.get_db)):
    users = crud.get_users(db, skip=skip, limit=limit)
    return users

# Thêm người dùng mới
@router.post("/users")
def create_user(name: str, email: str, phone: str, db: Session = Depends(database.get_db)):
    return crud.create_user(db, name, email, phone)
