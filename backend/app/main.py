from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from .database import engine, ensure_pending_users_table
from .models import Base
from .routers import (
    auth_router,
    payment_router,
    navigation_router,
    booking_router,
    order_router,
    cart_router,
    dish_router,
    password_router,
    registration_router
)
from .routers.profile import router as profile_router
from .Admin.routers.admin import router as admin_router



# Tạo bảng nếu chưa tồn tại
Base.metadata.create_all(bind=engine)
ensure_pending_users_table()


app = FastAPI(
    title="Restaurant Management System",
    description="Backend API for Restaurant Management System",
    version="1.0.0",
    docs_url="/api/docs",
    redoc_url="/api/redoc"
)

# CORS configuration
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include routers
app.include_router(auth_router, prefix="/api/auth", tags=["auth"])
app.include_router(payment_router, prefix="/api/payments", tags=["payments"])
app.include_router(navigation_router, prefix="/api/navigation", tags=["navigation"])
app.include_router(booking_router, prefix="/api/bookings", tags=["bookings"])
app.include_router(order_router, prefix="/api/orders", tags=["orders"])
app.include_router(profile_router, prefix="/api/profile", tags=["profile"])
app.include_router(cart_router, prefix="/api/cart", tags=["cart"])
app.include_router(dish_router, prefix="/api/dish", tags=["dish"])
# app.include_router(menu_router, prefix="/api/menu", tags=["menu"])
app.include_router(password_router, tags=["password"])
app.include_router(registration_router, tags=["registration"])
     

app.include_router(admin_router)


@app.get("/")
def read_root():
    return {"message": "Welcome to Restaurant Management System API, swagger = /api/docs, redoc = /api/redoc"}
