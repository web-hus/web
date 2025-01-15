from sqlalchemy.orm import Session
from datetime import datetime
from fastapi import HTTPException, status
from ..models.tables import ShoppingCart, ShoppingCartDish, Dish
from ..schemas import cart_schema

class CartService:
    @staticmethod
    def create_cart(db: Session, cart_data: cart_schema.CartCreate) -> ShoppingCart:
        """Create a new shopping cart"""
        db_cart = ShoppingCart(
            cart_id=cart_data.user_id,
            user_id=cart_data.user_id
        )
        db.add(db_cart)
        db.commit()
        db.refresh(db_cart)
        return db_cart

    @staticmethod
    def get_cart(db: Session, cart_id: int) -> ShoppingCart:
        """Get cart by ID"""
        cart = db.query(ShoppingCart).filter(ShoppingCart.cart_id == cart_id).first()
        if not cart:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Không tìm thấy giỏ hàng"
            )
        return cart

    @staticmethod
    def get_user_cart(db: Session, user_id: int) -> ShoppingCart:
        """Get cart for a user"""
        cart = db.query(ShoppingCart).filter(ShoppingCart.user_id == user_id).first()
        if not cart:
            # Tự động tạo giỏ hàng mới nếu chưa có
            cart = CartService.create_cart(db, cart_schema.CartCreate(user_id=user_id))
        return cart

    @staticmethod
    def add_dish_to_cart(db: Session, cart_dish: cart_schema.CartDishCreate) -> ShoppingCart:
        """Add a dish to cart"""
        # Kiểm tra món ăn có tồn tại không
        dish = db.query(Dish).filter(Dish.dish_id == cart_dish.dish_id).first()
        if not dish:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Không tìm thấy món ăn"
            )
        
        # Kiểm tra món ăn còn hàng không
        if dish.availability == 0:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Món ăn đã hết hàng"
            )

        # Kiểm tra món ăn đã có trong giỏ hàng chưa
        cart_dish_item = db.query(ShoppingCartDish).filter(
            ShoppingCartDish.cart_id == cart_dish.cart_id,
            ShoppingCartDish.dish_id == cart_dish.dish_id
        ).first()

        if cart_dish_item:
            # Nếu đã có thì cộng thêm số lượng
            cart_dish_item.quantity += cart_dish.quantity
        else:
            # Nếu chưa có thì tạo mới
            cart_dish_item = ShoppingCartDish(
                cart_id=cart_dish.cart_id,
                dish_id=cart_dish.dish_id,
                quantity=cart_dish.quantity
            )
            db.add(cart_dish_item)

        db.commit()
        return CartService.get_cart(db, cart_dish.cart_id)

    @staticmethod
    def remove_dish_from_cart(db: Session, cart_id: int, dish_id: str) -> ShoppingCart:
        """Remove a dish from cart"""
        cart_dish = db.query(ShoppingCartDish).filter(
            ShoppingCartDish.cart_id == cart_id,
            ShoppingCartDish.dish_id == dish_id
        ).first()

        if cart_dish:
            db.delete(cart_dish)
            db.commit()

        return CartService.get_cart(db, cart_id)

    @staticmethod
    def update_dish_quantity(db: Session, cart_id: int, dish_id: str, quantity: int) -> ShoppingCart:
        """Update dish quantity in cart"""
        if quantity <= 0:
            return CartService.remove_dish_from_cart(db, cart_id, dish_id)

        cart_dish = db.query(ShoppingCartDish).filter(
            ShoppingCartDish.cart_id == cart_id,
            ShoppingCartDish.dish_id == dish_id
        ).first()

        if not cart_dish:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Món ăn không có trong giỏ hàng"
            )

        cart_dish.quantity = quantity
        db.commit()
        return CartService.get_cart(db, cart_id)

    @staticmethod
    def clear_cart(db: Session, cart_id: int) -> ShoppingCart:
        """Remove all dishes from cart"""
        db.query(ShoppingCartDish).filter(ShoppingCartDish.cart_id == cart_id).delete()
        db.commit()
        return CartService.get_cart(db, cart_id)
