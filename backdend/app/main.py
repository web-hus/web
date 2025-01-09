import fastapi as _fastapi
from .routers import dish, user
import fastapi.security as _security

app = FastAPI()

# Đăng ký các router
app.include_router(dish.router)
app.include_router(user.router)

# API gốc
@app.get("/")
def read_root():
    return {"message": "Hello, this is your FastAPI backend!"}

@app.post("/token")
async def generate_token(form_data:_security.OAuth2PasswordRequestForm = _fastapi.Depends(), db:_orm.Session)
