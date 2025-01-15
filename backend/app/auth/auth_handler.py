import jwt
from datetime import datetime, timedelta
from fastapi import HTTPException, status, Depends
from fastapi.security import OAuth2PasswordBearer
import os
from dotenv import load_dotenv

load_dotenv()

# Lấy secret key từ env
SECRET_KEY = os.getenv("SECRET_KEY", "your-secret-key")
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 60 * 24 * 7  # Token hết hạn sau 7 ngày

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/api/auth/login")

def decode_jwt(token: str) -> dict:
    """
    Decode và verify JWT token
    :param token: JWT token string
    :return: Dictionary chứa thông tin từ token payload
    """
    try:
        # Decode token
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        
        # Lấy thông tin cần thiết
        user_id = payload.get("user_id")
        role = payload.get("role")
        
        if user_id is None or role is None:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Token không hợp lệ"
            )
            
        return {"user_id": user_id, "role": role}
        
    except jwt.ExpiredSignatureError:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Token đã hết hạn"
        )
    except jwt.InvalidTokenError:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Token không hợp lệ"
        )
    except Exception as e:
        print(f"Token verification error: {e}")
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Lỗi xác thực token"
        )

def create_access_token(data: dict) -> str:
    """
    Tạo JWT access token
    :param data: Dictionary chứa thông tin user (user_id, role)
    :return: JWT token string
    """
    to_encode = data.copy()
    
    # Thêm thời gian hết hạn
    expire = datetime.utcnow() + timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    to_encode.update({"exp": expire})
    
    try:
        encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
        return encoded_jwt
    except Exception as e:
        print(f"Error creating token: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Lỗi khi tạo token"
        )

def get_current_user(token: str = Depends(oauth2_scheme)) -> dict:
    """
    Dependency để lấy thông tin user hiện tại từ token
    :param token: JWT token từ Authorization header
    :return: Dictionary chứa thông tin user
    """
    return decode_jwt(token)

def is_admin(current_user: dict = Depends(get_current_user)) -> dict:
    """
    Dependency để kiểm tra quyền admin
    :param current_user: Dictionary chứa thông tin user từ token
    :return: Dictionary chứa thông tin user nếu là admin
    """
    if current_user.get("role") != 1:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Bạn không có quyền thực hiện hành động này"
        )
    return current_user
