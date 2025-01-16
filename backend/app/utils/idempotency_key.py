import uuid
from datetime import datetime
import hashlib
import random
import string

class IdempotencyKeyGenerator:
    @staticmethod
    def generate_key() -> str:
        """
        Tạo Idempotency Key duy nhất kết hợp UUID, timestamp và random string
        Format: [timestamp]-[uuid]-[random_string]
        """
        # Tạo timestamp
        timestamp = datetime.utcnow().strftime('%Y%m%d%H%M%S%f')
        
        # Tạo UUID
        unique_id = str(uuid.uuid4())
        
        # Tạo random string
        random_string = ''.join(random.choices(string.ascii_letters + string.digits, k=8))
        
        # Kết hợp các thành phần
        combined = f"{timestamp}-{unique_id}-{random_string}"
        
        # Hash kết quả để có độ dài cố định
        hashed = hashlib.sha256(combined.encode()).hexdigest()
        
        return hashed

    @staticmethod
    def is_valid_key(key: str) -> bool:
        """
        Kiểm tra tính hợp lệ của Idempotency Key
        - Phải là chuỗi hex 64 ký tự (SHA-256)
        """
        if not isinstance(key, str):
            return False
            
        # Kiểm tra độ dài
        if len(key) != 64:
            return False
            
        # Kiểm tra các ký tự hợp lệ (hex)
        try:
            int(key, 16)
            return True
        except ValueError:
            return False
