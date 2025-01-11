from sqlalchemy.orm import Session
from datetime import datetime, timedelta
from ..models import cart_model
from ..schemas import cart_schema
from fastapi import HTTPException
from ..services.dish_service import DishService

class CartService:
    @staticmethod
    def get_cart(db: Session, user_id: int):
        """Get or create shopping cart for user"""
        cart = db.query(cart_model.ShoppingCart).filter(
            cart_model.ShoppingCart.user_id == user_id
        ).first()

        if not cart:
            cart = cart_model.ShoppingCart(
                user_id=user_id,
                created_at=datetime.utcnow(),
                updated_at=datetime.utcnow()
            )
            db.add(cart)
            db.commit()
            db.refresh(cart)

        # Check cart timeout (30 minutes)
        if datetime.utcnow() - cart.updated_at > timedelta(minutes=30):
            CartService.clear_cart(db, cart.cart_id)
            cart.updated_at = datetime.utcnow()
            db.commit()

        return cart

    @staticmethod
    def check_cart_timeout(cart: cart_model.ShoppingCart):
        timeout_minutes = 10
        if datetime.utcnow() - cart.updated_at > timedelta(minutes=timeout_minutes):
            raise HTTPException(status_code=401, detail="Thời gian đặt hàng đã hết. Vui lòng đăng nhập lại.")

    @staticmethod
    def add_dish_to_cart(db: Session, user_id: int, dish_id: str, quantity: int):
        dish = DishService.get_dish(db, dish_id)
        if dish.availability != 1:
            raise HTTPException(status_code=400, detail="Món ăn hiện đã hết")

        cart = CartService.get_cart(db, user_id)
        CartService.check_cart_timeout(cart)

        cart_dish = db.query(cart_model.ShoppingCartDish).filter(
            cart_model.ShoppingCartDish.cart_id == cart.cart_id,
            cart_model.ShoppingCartDish.dish_id == dish.dish_id
        ).first()

        if cart_dish:
            cart_dish.quantity += quantity
        else:
            cart_dish = cart_model.ShoppingCartDish(
                cart_id=cart.cart_id,
                dish_id=dish_id,
                quantity=quantity
            )
            db.add(cart_dish)
        cart.updated_at = datetime.utcnow()
        db.commit()
        db.refresh(cart)
        return cart

    @staticmethod
    def update_dish_quantity(db: Session, user_id: int, dish_id: str, quantity: int):
        dish = DishService.get_dish(db, dish_id)
        if dish.availability != 1:
            raise HTTPException(status_code=400, detail="Dish is not available")

        cart = CartService.get_cart(db, user_id)
        CartService.check_cart_timeout(cart)

        cart_dish = db.query(cart_model.ShoppingCartDish).filter(
            cart_model.ShoppingCartDish.cart_id == cart.cart_id,
            cart_model.ShoppingCartDish.dish_id == dish_id
        ).first()

        if not cart_dish:
            raise HTTPException(status_code=404, detail="Dish not found in cart")

        if quantity <= 0:
            db.delete(cart_dish)
        else:
            DishService.check_dish_availability(db, dish_id)
            cart_dish.quantity = quantity

        cart.updated_at = datetime.utcnow()
        db.commit()
        db.refresh(cart)
        return cart

    @staticmethod
    def remove_dish_from_cart(db: Session, user_id: int, dish_id: str):
        cart = CartService.get_cart(db, user_id)
        CartService.check_cart_timeout(cart)

        result = db.query(cart_model.ShoppingCartDish).filter(
            cart_model.ShoppingCartDish.cart_id == cart.cart_id,
            cart_model.ShoppingCartDish.dish_id == dish_id
        ).delete()

        if result == 0:
            raise HTTPException(status_code=404, detail="Không tìm thấy món ăn trong giỏ hàng")

        cart.updated_at = datetime.utcnow()
        db.commit()
        db.refresh(cart)
        return cart

    @staticmethod
    def clear_cart(db: Session, cart_id: int):
        """Clear all dishes from cart"""
        db.query(cart_model.ShoppingCartDish).filter(
            cart_model.ShoppingCartDish.cart_id == cart_id
        ).delete()
        db.commit()
