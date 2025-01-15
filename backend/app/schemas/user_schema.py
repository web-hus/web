from pydantic import BaseModel, Field, EmailStr, ConfigDict, validator, constr
from typing import Optional
from datetime import datetime
import re

class UserBase(BaseModel):
    user_name: str = Field(..., min_length=2, max_length=50)
    age: int = Field(..., ge=18, le=100)
    gender: str = Field(..., pattern=r'^[MF]$')
    address: str = Field(..., min_length=5, max_length=200)
    email: EmailStr
    phone: str = Field(..., pattern=r'^[0-9]{10}$')
    role: int = Field(default=0)  # 0: Customer, 1: Admin

class UserCreate(UserBase):
    password: str = Field(..., min_length=8)

    @validator('password')
    def validate_password(cls, v):
        if not re.match(r'^[A-Za-z\d]{8,}$', v):
            raise ValueError('Password must be at least 8 characters')
        if not any(c.isalpha() for c in v):
            raise ValueError('Password must contain at least one letter')
        if not any(c.isdigit() for c in v):
            raise ValueError('Password must contain at least one number')
        return v

class UserLogin(BaseModel):
    email: EmailStr
    password: str

class UserUpdate(BaseModel):
    user_name: Optional[str] = Field(None, min_length=2, max_length=50)
    age: Optional[int] = Field(None, ge=18, le=100)
    gender: Optional[str] = Field(None, pattern=r'^[MF]$')
    address: Optional[str] = Field(None, min_length=5, max_length=200)
    email: Optional[EmailStr] = None
    phone: Optional[str] = Field(None, pattern=r'^[0-9]{10}$')
    password: Optional[str] = None

    @validator('password')
    def validate_password(cls, v):
        if v is None:
            return v
        if not re.match(r'^[A-Za-z\d]{8,}$', v):
            raise ValueError('Password must be at least 8 characters')
        if not any(c.isalpha() for c in v):
            raise ValueError('Password must contain at least one letter')
        if not any(c.isdigit() for c in v):
            raise ValueError('Password must contain at least one number')
        return v

class User(UserBase):
    model_config = ConfigDict(from_attributes=True)

    user_id: int
    created_at: datetime
    updated_at: datetime

class UserInDB(User):
    password: str

class Token(BaseModel):
    access_token: str
    refresh_token: str
    token_type: str = "bearer"
    user_id: int
    role: int

class TokenData(BaseModel):
    user_id: int
    role: int
    exp: datetime
    type: str  # "access" or "refresh"
