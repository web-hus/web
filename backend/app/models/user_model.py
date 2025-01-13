from sqlalchemy import Column, Integer, String, Text, DateTime, func
from .base import Base

class User(Base):
    __tablename__ = 'users'
    
    user_id = Column(Integer, primary_key=True, autoincrement=True)
    user_name = Column(String(255), nullable=False)
    age = Column(Integer, nullable=False)
    gender = Column(String(1), nullable=False)
    address = Column(Text, nullable=False)
    email = Column(String(255), unique=True, nullable=False)
    phone = Column(String(15), unique=True, nullable=False)
    created_at = Column(DateTime, default=func.now())
    updated_at = Column(DateTime, default=func.now(), onupdate=func.now())
    password = Column(Text, nullable=False)
    role = Column(Integer, nullable=False, default=0)  # 0: Khách hàng, 1: Admin
    
    def verify_password(self, password: str):
        return password == self.password

    
    def __repr__(self):
        return f"<User(user_id={self.user_id}, user_name={self.user_name}, email={self.email})>"
