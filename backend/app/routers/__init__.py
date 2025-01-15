from fastapi import APIRouter
from .auth import router as auth_router
from .admin import router as admin_router
from .booking import router as booking_router
from .payment import router as payment_router
from .dish import router as dish_router
from .order import router as order_router
from .user import router as user_router
from .password import router as password_router

api_router = APIRouter()

# Đăng ký các router
api_router.include_router(auth_router)
api_router.include_router(admin_router)
api_router.include_router(booking_router)
api_router.include_router(payment_router)
api_router.include_router(dish_router)
api_router.include_router(order_router)
api_router.include_router(user_router)
api_router.include_router(password_router)

__all__ = [
    'api_router',
    'auth_router',
    'admin_router',
    'booking_router',
    'payment_router',
    'dish_router',
    'order_router',
    'user_router',
    'password_router'
]
