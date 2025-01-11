from ..schemas.navigation_schema import NavigationItem
from typing import List
from sqlalchemy.orm import Session
from ..models import category_model

class NavigationService:
    @staticmethod
    def get_main_navigation() -> List[NavigationItem]:
        """Get main navigation items"""
        return [
            NavigationItem(
                id="home",
                title="Trang chủ",
                path="/",
                icon="home"
            ),
            NavigationItem(
                id="menu",
                title="Thực đơn",
                path="/menu",
                icon="restaurant_menu"
            ),
            NavigationItem(
                id="about",
                title="Giới thiệu",
                path="/about",
                icon="info"
            ),
            NavigationItem(
                id="news",
                title="Tin tức",
                path="/news",
                icon="article"
            ),
            NavigationItem(
                id="contact",
                title="Liên hệ",
                path="/contact",
                icon="contact_support"
            ),
            NavigationItem(
                id="booking",
                title="Đặt bàn",
                path="/booking",
                icon="event_seat"
            )
        ]

    @staticmethod
    def get_user_navigation() -> List[NavigationItem]:
        """Get user-specific navigation items"""
        return [
            NavigationItem(
                id="profile",
                title="Thông tin cá nhân",
                path="/profile",
                icon="person"
            ),
            NavigationItem(
                id="orders",
                title="Đơn hàng của tôi",
                path="/orders",
                icon="receipt"
            ),
            NavigationItem(
                id="bookings",
                title="Lịch đặt bàn",
                path="/bookings",
                icon="event"
            ),
            NavigationItem(
                id="favorites",
                title="Món ăn yêu thích",
                path="/favorites",
                icon="favorite"
            )
        ]

    @staticmethod
    def get_admin_navigation() -> List[NavigationItem]:
        """Get admin navigation items"""
        return [
            NavigationItem(
                id="dashboard",
                title="Dashboard",
                path="/admin/dashboard",
                icon="dashboard"
            ),
            NavigationItem(
                id="dishes",
                title="Quản lý món ăn",
                path="/admin/dishes",
                icon="restaurant"
            ),
            NavigationItem(
                id="orders",
                title="Quản lý đơn hàng",
                path="/admin/orders",
                icon="shopping_cart"
            ),
            NavigationItem(
                id="bookings",
                title="Đặt bàn (Offline)",
                path="/admin/bookings",
                icon="table_restaurant"
            ),
            NavigationItem(
                id="users",
                title="Quản lý user",
                path="/admin/users",
                icon="people"
            )
        ]

    @staticmethod
    def get_category_navigation(db: Session) -> List[NavigationItem]:
        """Get category navigation from database"""
        categories = db.query(category_model.Category).all()
        return [
            NavigationItem(
                id=cat.category_id,
                title=cat.name,
                path=f"/menu/{cat.category_id}",
                icon="category"
            ) for cat in categories
        ]
