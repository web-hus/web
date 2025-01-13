from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from .database import engine
from .models import Base
from .routers import (
    auth_router,
    dish_router,
    cart_router,
    payment_router,
    navigation_router,
    booking_router,
    order_router
)

# Tạo bảng nếu chưa tồn tại
Base.metadata.create_all(bind=engine)

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
app.include_router(dish_router, prefix="/api/dishes", tags=["dishes"])
app.include_router(cart_router, prefix="/api/cart", tags=["cart"])
app.include_router(payment_router, prefix="/api/payments", tags=["payments"])
app.include_router(navigation_router, prefix="/api/navigation", tags=["navigation"])
app.include_router(booking_router, prefix="/api/bookings", tags=["bookings"])
app.include_router(order_router, prefix="/api/orders", tags=["orders"])

@app.get("/")
def read_root():
    return {"message": "Welcome to Restaurant Management System API"}
