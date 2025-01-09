from .. import crud, models, database
from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from app.models import User
from app.database import SessionLocal
from pydantic import BaseModel
from passlib.context import CryptContext
import passlib.hash as _hash

router = APIRouter()

# Dependency để lấy session
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# Schema cho đăng ký
class UserCreate(BaseModel):
    user_name: str
    age: int
    gender: str
    address: str
    phone: str
    email: str
    password: str

# Schema cho đăng nhập
class UserLogin(BaseModel):
    email: str
    password: str

# Lấy danh sách người dùng
@router.get("/users")
async def get_users(skip: int = 0, limit: int = 100, db: Session = Depends(database.get_db)):
    users = crud.get_users(db, skip=skip, limit=limit)
    return users

# Cấu hình mã hóa mật khẩu
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

# Hàm hash mật khẩu
def hash_password(password: str):
    return pwd_context.hash(password)

# Hàm kiểm tra mật khẩu
def verify_password(plain_password: str, hashed_password: str):
    return pwd_context.verify(plain_password, hashed_password)

# Đăng ký tài khoản
@router.post("/register")
async def register_user(user: UserCreate, db: Session = Depends(get_db)):
    # Kiểm tra email đã tồn tại chưa
    existing_user = db.query(User).filter(User.email == user.email).first()
    if existing_user:
        raise HTTPException(status_code=400, detail="Email already registered")
    
    # Tạo user mới
    new_user = User(
        user_name=user.user_name,
        age=user.age,
        gender=user.gender,
        address=user.address,
        phone=user.phone,
        email=user.email,
        password=_hash.bcrypt.hash(user.password),  # Mã hóa password
    )
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    return {"message": "User registered successfully", "user_id": new_user.user_id}

# Đăng nhập
@router.post("/login")
async def login_user(user: UserLogin, db: Session = Depends(get_db)):
    # Tìm user theo email
    db_user = db.query(User).filter(User.email == user.email).first()
    if not db_user:
        raise HTTPException(status_code=400, detail="Invalid email or password")
    
    # Kiểm tra password
    if not verify_password(user.password, db_user.password):
        raise HTTPException(status_code=400, detail="Invalid email or password")
    
    return {"message": "Login successful", "user_id": db_user.user_id}
