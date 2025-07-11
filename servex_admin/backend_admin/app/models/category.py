# app/models/category.py
from sqlalchemy import Column, Integer, String
from app.database import Base

class Category(Base):
    __tablename__ = 'categories'

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    image = Column(String, nullable=False)
    status = Column(String, default='Active')
