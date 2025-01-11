from pydantic import BaseModel, Field, EmailStr, constr
from typing import Optional
from datetime import datetime

class UserBase(BaseModel):
    username: str = Field(..., min_length=3, max_length=50)
    email: EmailStr
    full_name: str = Field(..., min_length=2, max_length=100)
    phone: str = Field(..., pattern=r'^\+?[0-9]{10,12}$')

class UserCreate(UserBase):
    password: str = Field(..., min_length=8, pattern=r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$')
    role: str = Field(default="user", pattern=r'^(user|admin)$')

class UserUpdate(BaseModel):
    username: Optional[str] = Field(None, min_length=3, max_length=50)
    email: Optional[EmailStr] = None
    full_name: Optional[str] = Field(None, min_length=2, max_length=100)
    phone: Optional[str] = Field(None, pattern=r'^\+?[0-9]{10,12}$')
    password: Optional[str] = Field(None, min_length=8, pattern=r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$')

class User(UserBase):
    user_id: str = Field(..., pattern=r'^U\d{3}$')
    role: str = Field(..., pattern=r'^(user|admin)$')
    is_active: bool = True
    created_at: datetime = Field(default_factory=datetime.now)
    updated_at: datetime = Field(default_factory=datetime.now)

    class Config:
        from_attributes = True

class UserInDB(User):
    hashed_password: str

class Token(BaseModel):
    access_token: str
    token_type: str = "bearer"

class TokenData(BaseModel):
    username: Optional[str] = None
    role: Optional[str] = None
