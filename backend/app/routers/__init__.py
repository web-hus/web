from .auth import router as auth_router
from .payment import router as payment_router
from .navigation import router as navigation_router
from .booking import router as booking_router
from .order import router as order_router
from .cart import router as cart_router
from .dish import router as dish_router
from .menu import router as menu_router
from .password import router as password_router
from .registration import router as registration_router

__all__ = [
    "auth_router",
    "payment_router",
    "navigation_router",
    "booking_router",
    "order_router",
    "cart_router",
    "dish_router",
    "menu_router",
    "password_router",
    "registration_router"
]
