from sqlalchemy import Column, Integer, String, Text, DateTime, func
from .base import Base

class PendingUser(Base):
    __tablename__ = 'pending_users'
    
    id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(255), nullable=False)
    age = Column(Integer, nullable=False)
    gender = Column(String(1), nullable=False)
    address = Column(Text, nullable=False)
    email = Column(String(255), unique=True, nullable=False)
    phone = Column(String(15), unique=True, nullable=False)
    password = Column(Text, nullable=False)
    verification_token = Column(String(255), unique=True, nullable=False)
    expires_at = Column(DateTime, nullable=False)
    created_at = Column(DateTime, default=func.now())
    
    def __repr__(self):
        return f"<PendingUser(id={self.id}, name={self.name}, email={self.email})>"
