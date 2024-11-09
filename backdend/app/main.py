# backend/app/main.py
from fastapi import FastAPI
from .routers import user
from .database import engine
from .models import user as user_model

app = FastAPI()

# Khởi tạo database (nếu chưa tạo)
user_model.Base.metadata.create_all(bind=engine)

# Include router cho các endpoint
app.include_router(user.router)

@app.get("/")
async def root():
    return {"message": "Welcome to the API"}
