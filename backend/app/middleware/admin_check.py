from fastapi import HTTPException, Depends, status
from ..auth.auth_handler import get_current_user

async def admin_required(current_user: dict = Depends(get_current_user)):
    """Check if current user is admin"""
    try:
        print(f"Checking admin rights for user: {current_user}")  # Debug print
        
        if not current_user:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Không thể xác thực người dùng"
            )
            
        if "role" not in current_user:
            print(f"Missing role in user data: {current_user}")
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Token không hợp lệ"
            )
            
        if current_user["role"] != 1:  # 1 là role admin
            print(f"User {current_user['user_id']} is not admin. Role: {current_user['role']}")
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="Bạn không có quyền thực hiện hành động này"
            )
            
        print(f"Admin check passed for user {current_user['user_id']}")
        return current_user
        
    except HTTPException as he:
        raise he
    except Exception as e:
        print(f"Admin check error: {str(e)}")
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Không thể xác thực người dùng"
        )
