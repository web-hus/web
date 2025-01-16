from fastapi import Request, HTTPException
from fastapi.responses import JSONResponse
from starlette.middleware.base import BaseHTTPMiddleware, RequestResponseEndpoint
import time
from typing import Optional
import redis
from dotenv import load_dotenv
import os

load_dotenv()

class RateLimiter(BaseHTTPMiddleware):
    def __init__(self, app, requests_per_minute: int = 60, window_seconds: int = 30):
        super().__init__(app)
        self.requests_per_minute = requests_per_minute
        self.window_seconds = window_seconds  # Giảm window time xuống 30 giây
        
        # Khởi tạo Redis connection
        self.redis = redis.Redis(
            host=os.getenv('REDIS_HOST', 'localhost'),
            port=int(os.getenv('REDIS_PORT', 6379)),
            db=0,
            decode_responses=True
        )

    def _get_rate_limit_key(self, client_id: str) -> str:
        """Tạo key cho Redis dựa trên client ID"""
        return f"rate_limit:{client_id}"

    async def dispatch(self, request: Request, call_next: RequestResponseEndpoint):
        # Lấy client identifier (IP address hoặc user ID nếu đã xác thực)
        client_id = request.client.host
        rate_limit_key = self._get_rate_limit_key(client_id)
        
        current_time = int(time.time())
        window_start = current_time - self.window_seconds

        try:
            # Sử dụng Redis pipeline để thực hiện nhiều thao tác atomic
            pipe = self.redis.pipeline()
            
            # Xóa các request cũ hơn window time
            pipe.zremrangebyscore(rate_limit_key, 0, window_start)
            
            # Đếm số request trong window time
            pipe.zcount(rate_limit_key, window_start, current_time)
            
            # Thêm request mới
            pipe.zadd(rate_limit_key, {str(current_time): current_time})
            
            # Set expire cho key để tự động cleanup
            pipe.expire(rate_limit_key, self.window_seconds)
            
            # Thực thi pipeline
            _, request_count, _, _ = pipe.execute()

            # Kiểm tra rate limit
            if request_count >= self.requests_per_minute:
                return JSONResponse(
                    status_code=429,
                    content={
                        "detail": "Too many requests. Please try again later.",
                        "retry_after": self.window_seconds
                    }
                )

            # Xử lý request nếu trong giới hạn
            response = await call_next(request)
            return response

        except redis.RedisError as e:
            # Fallback khi Redis không khả dụng
            print(f"Redis error: {e}")
            return await call_next(request)
