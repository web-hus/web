from pydantic import BaseModel, Field, EmailStr
from typing import Optional
from datetime import datetime

class UserBase(BaseModel):
    user_name: str
    age: int = Field(..., gt=0)
    gender: str = Field(..., pattern='^[MF]$')
    address: str
    email: EmailStr
    phone: str = Field(..., pattern=r'^\+?[0-9]{10,12}$')

class UserCreate(UserBase):
    password: str
    role: int = Field(0, ge=0, le=1)  # 0: Khách hàng, 1: Quản trị viên

class UserUpdate(BaseModel):
    user_name: Optional[str] = None
    age: Optional[int] = Field(None, gt=0)
    gender: Optional[str] = Field(None, pattern='^[MF]$')
    address: Optional[str] = None
    email: Optional[EmailStr] = None
    phone: Optional[str] = Field(None, pattern=r'^\+?[0-9]{10,12}$')
    password: Optional[str] = None

class User(UserBase):
    user_id: int
    role: int = Field(..., ge=0, le=1)
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True

class Token(BaseModel):
    access_token: str
    token_type: str = "bearer"

class TokenData(BaseModel):
    user_id: int
    role: int
