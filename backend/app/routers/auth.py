from fastapi import APIRouter, Depends, HTTPException, status
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy.orm import Session
from ..database import get_db
from ..services.user_service import UserService
from ..auth.auth_handler import signJWT
from ..schemas.user_schema import UserCreate
from ..models.user_model import User
from ..services.cart_service import CartService
from .. schemas.cart_schema import CartCreate
router = APIRouter(
    prefix="/auth",
    tags=["auth"]
)

@router.post("/register")
async def register_user(user: UserCreate, db: Session = Depends(get_db)):
    # Kiểm tra email đã tồn tại chưa
    existing_user = db.query(User).filter(User.email == user.email).first()
    if existing_user:
        raise HTTPException(status_code=400, detail="Email already registered")
    
    # Tạo user mới
    new_user = User(
        user_name=user.user_name,
        age=user.age,
        gender=user.gender,
        address=user.address,
        phone=user.phone,
        email=user.email,
        # password=_hash.bcrypt.hash(user.password),  # Mã hóa password
        password = user.password,
    )
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    cart = CartService.create_cart(db=db, cart_data=CartCreate(user_id=new_user.user_id))

    return {
        "message": "User registered successfully",
        "user_id": new_user.user_id,
        "cart_id": cart.cart_id,
    }

@router.post("/token")
async def login(
    form_data: OAuth2PasswordRequestForm = Depends(),
    db: Session = Depends(get_db)
):
    """
    Login endpoint to get JWT token
    - username: email của user
    - password: mật khẩu
    """
    user = await UserService.authenticate_user(db, form_data.username, form_data.password)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Email hoặc mật khẩu không chính xác",
            headers={"WWW-Authenticate": "Bearer"},
        )
    
    token = signJWT(user_id=user.user_id,role= user.role)
    return {
        **token,
        "user_id": user.user_id,
        "role": user.role
    }
