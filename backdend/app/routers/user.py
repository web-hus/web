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

from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from app.models import User
from app.database import SessionLocal
from pydantic import BaseModel, EmailStr
from passlib.context import CryptContext

router = APIRouter()

# Cấu hình mã hóa mật khẩu
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

# Dependency để lấy session
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# Schema cho đăng ký
class UserCreate(BaseModel):
    name: str
    age: int
    gender: str
    address: str
    phone: str
    email: EmailStr
    password: str

# Schema cho đăng nhập
class UserLogin(BaseModel):
    email: EmailStr
    password: str

# Hàm hash mật khẩu
def hash_password(password: str):
    return pwd_context.hash(password)

# Hàm kiểm tra mật khẩu
def verify_password(plain_password: str, hashed_password: str):
    return pwd_context.verify(plain_password, hashed_password)

# Đăng ký tài khoản
@router.post("/register")
def register_user(user: UserCreate, db: Session = Depends(get_db)):
    # Kiểm tra email đã tồn tại chưa
    existing_user = db.query(User).filter(User.email == user.email).first()
    if existing_user:
        raise HTTPException(status_code=400, detail="Email already registered")
    
    # Tạo user mới
    new_user = User(
        name=user.name,
        age=user.age,
        gender=user.gender,
        address=user.address,
        phone=user.phone,
        email=user.email,
        password=hash_password(user.password),  # Mã hóa password
    )
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    return {"message": "User registered successfully", "user_id": new_user.user_id}

# Đăng nhập
@router.post("/login")
def login_user(user: UserLogin, db: Session = Depends(get_db)):
    # Tìm user theo email
    db_user = db.query(User).filter(User.email == user.email).first()
    if not db_user:
        raise HTTPException(status_code=400, detail="Invalid email or password")
    
    # Kiểm tra password
    if not verify_password(user.password, db_user.password):
        raise HTTPException(status_code=400, detail="Invalid email or password")
    
    return {"message": "Login successful", "user_id": db_user.user_id}
