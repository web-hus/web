from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from ..database import get_db
from ..schemas import cart_schema
from ..services.cart_service import CartService
from ..auth.auth_bearer import JWTBearer
from ..auth.auth_handler import decodeJWT

router = APIRouter(
    prefix="/cart",
    tags=["cart"],
    dependencies=[Depends(JWTBearer())]
)

def get_current_user(token: str = Depends(JWTBearer())):
    return decodeJWT(token)

@router.get("/")
def get_cart(
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """Get user's shopping cart"""
    return CartService.get_cart(db, current_user["user_id"])

@router.post("/dishes")
def add_to_cart(
    dish: cart_schema.CartDishCreate,
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """Add dish to cart"""
    return CartService.add_to_cart(db, current_user["user_id"], dish)

@router.put("/dishes/{dish_id}")
def update_cart_dish(
    dish_id: str,
    quantity: int,
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """Update dish quantity in cart"""
    return CartService.update_cart_dish(db, current_user["user_id"], dish_id, quantity)

@router.delete("/dishes/{dish_id}")
def remove_from_cart(
    dish_id: str,
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """Remove dish from cart"""
    return CartService.remove_from_cart(db, current_user["user_id"], dish_id)
