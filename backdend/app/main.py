from fastapi import FastAPI
from .routers import dish, user

app = FastAPI()

# Đăng ký các router
app.include_router(dish.router)
app.include_router(user.router)

# API gốc
@app.get("/")
def read_root():
    return {"message": "Hello, this is your FastAPI backend!"}
