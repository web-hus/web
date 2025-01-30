from sqlalchemy import Column, String, DateTime, JSON, func
from .base import Base

class IdempotencyKey(Base):
    __tablename__ = 'idempotency_keys'
    
    key = Column(String(255), primary_key=True)
    endpoint = Column(String(255), nullable=False)
    response_data = Column(JSON, nullable=True)
    created_at = Column(DateTime, default=func.now())
    expires_at = Column(DateTime, nullable=False)
    
    def __repr__(self):
        return f"<IdempotencyKey(key={self.key}, endpoint={self.endpoint})>"
