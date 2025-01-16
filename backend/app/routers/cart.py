from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session, joinedload
from typing import List

from ..database import get_db
from ..services.cart_service import CartService
from ..schemas.cart_schema import CartCreate, Cart, CartDishCreate
from ..auth.auth_bearer import JWTBearer
from ..auth.auth_handler import get_current_user
from ..models.shopping_cart_model import ShoppingCart, ShoppingCartDish

router = APIRouter(
    prefix="/cart",
    tags=["cart"],
    dependencies=[Depends(JWTBearer())]
)

@router.post("/", response_model=Cart)
def create_cart(
    cart: CartCreate,
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """Tạo giỏ hàng mới"""
    return CartService.create_cart(db=db, cart_data=cart)

@router.get("/{cart_id}", response_model=Cart)
def get_cart(
    cart_id: int,
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """Lấy thông tin giỏ hàng theo ID"""
    cart = CartService.get_cart(db=db, cart_id=cart_id)
    if current_user["user_id"] != cart.user_id and current_user.get("role") != 1:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Không có quyền xem giỏ hàng của người khác"
        )
    return cart

@router.get("/user/{user_id}", response_model=Cart)
def get_user_cart(
    user_id: int,
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """Lấy giỏ hàng của user"""
    if current_user["user_id"] != user_id and current_user.get("role") != 1:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Không có quyền truy cập giỏ hàng của user khác"
        )
    return CartService.get_user_cart(db=db, user_id=user_id)

@router.get("", response_model=Cart, summary="Get user's shopping cart")
async def get_user_cart(
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """Get the shopping cart of the currently logged in user"""
    try:
        cart = (
            db.query(ShoppingCart)
            .options(joinedload(ShoppingCart.dishes).joinedload(ShoppingCartDish.dish))
            .filter(ShoppingCart.user_id == current_user["user_id"])
            .first()
        )
        
        if not cart:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Shopping cart not found"
            )
            
        return cart
    except Exception as e:
        if isinstance(e, HTTPException):
            raise e
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Error getting cart: {str(e)}"
        )

@router.post("/add-dish", response_model=Cart)
def add_dish_to_cart(
    cart_dish: CartDishCreate,
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """Thêm món ăn vào giỏ hàng"""
    cart = CartService.get_cart(db=db, cart_id=cart_dish.cart_id)
    if current_user["user_id"] != cart.user_id:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Không có quyền thêm món vào giỏ hàng của người khác"
        )
    return CartService.add_dish_to_cart(db=db, cart_dish=cart_dish)

@router.delete("/remove-dish/{cart_id}/{dish_id}", response_model=Cart)
def remove_dish_from_cart(
    cart_id: int,
    dish_id: str,
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """Xóa món ăn khỏi giỏ hàng"""
    cart = CartService.get_cart(db=db, cart_id=cart_id)
    if current_user["user_id"] != cart.user_id:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Không có quyền xóa món khỏi giỏ hàng của người khác"
        )
    return CartService.remove_dish_from_cart(db=db, cart_id=cart_id, dish_id=dish_id)

@router.put("/update-quantity/{cart_id}/{dish_id}", response_model=Cart)
def update_dish_quantity(
    cart_id: int,
    dish_id: str,
    quantity: int,
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """Cập nhật số lượng món ăn trong giỏ hàng"""
    cart = CartService.get_cart(db=db, cart_id=cart_id)
    if current_user["user_id"] != cart.user_id:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Không có quyền cập nhật giỏ hàng của người khác"
        )
    return CartService.update_dish_quantity(db=db, cart_id=cart_id, dish_id=dish_id, quantity=quantity)

@router.delete("/clear/{cart_id}", response_model=Cart)
def clear_cart(
    cart_id: int,
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """Xóa tất cả món ăn trong giỏ hàng"""
    cart = CartService.get_cart(db=db, cart_id=cart_id)
    if current_user["user_id"] != cart.user_id:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Không có quyền xóa giỏ hàng của người khác"
        )
    return CartService.clear_cart(db=db, cart_id=cart_id)
