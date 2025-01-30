from pydantic import BaseModel, EmailStr, constr, validator
from typing import Optional
from datetime import datetime

class UserRegistration(BaseModel):
    user_name: constr(min_length=2, max_length=255)
    age: int
    gender: constr(pattern="^[MF]$")  # M for Male, F for Female
    address: str
    email: EmailStr
    phone: constr(pattern="^[0-9]{10,15}$")
    password: constr(min_length=6)
    # confirm_password: str

    # @validator('age')
    # def validate_age(cls, v):
    #     if v < 0 or v > 150:
    #         raise ValueError('Age must be between 0 and 150')
    #     return v

    # @validator('confirm_password')
    # def passwords_match(cls, v, values, **kwargs):
    #     if 'password' in values and v != values['password']:
    #         raise ValueError('Passwords do not match')
    #     return v

class VerifyRegistration(BaseModel):
    token: str
