import fastapi as _fastapi
import fastapi.security as _security
import fastapi.security as _security
from typing import TYPE_CHECKING, List
import sqlalchemy.orm as _orm
from sqlalchemy.orm import Session

from .routers import dish
from .routers import user as _user

from .models import User


app = _fastapi.FastAPI()

# Đăng ký các router
app.include_router(dish.router)
app.include_router(_user.router)

# API gốc
@app.get("/")
def read_root():
    return {"message": "Hello, this is your FastAPI backend!"}

@app.post("/token")
async def generate_token(form_data:_security.OAuth2PasswordRequestForm = _fastapi.Depends(), db:"Session" = _fastapi.Depends(_user.get_db)):
    user = await _user.authenticate_user(form_data.username, form_data.password, db)
    
    if not user:
        raise _fastapi.HTTPException(status_code=401, detail = "invalid credentials")
    
    return await _user.create_token(user)
