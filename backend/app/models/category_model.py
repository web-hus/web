from sqlalchemy import Column, String, Text
from .base import Base

class Category(Base):
    __tablename__ = 'categories'
    
    category_id = Column(String, primary_key=True)
    name = Column(String, nullable=False)
    description = Column(Text)

    def __repr__(self):
        return f"<Category(category_id={self.category_id}, name={self.name})>"
