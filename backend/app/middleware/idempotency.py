from fastapi import Request, HTTPException, status
from starlette.middleware.base import BaseHTTPMiddleware, RequestResponseEndpoint
from starlette.responses import Response
from sqlalchemy.orm import Session
from datetime import datetime, timedelta
from ..models.idempotency_model import IdempotencyKey
from ..database import SessionLocal
import json

class IdempotencyMiddleware(BaseHTTPMiddleware):
    def __init__(self, app, expires_in_hours: int = 24):
        super().__init__(app)
        self.expires_in_hours = expires_in_hours

    async def dispatch(
        self, request: Request, call_next: RequestResponseEndpoint
    ) -> Response:
        # Only check idempotency for specific endpoints and POST methods
        if not self._should_check_idempotency(request):
            return await call_next(request)

        idempotency_key = request.headers.get("Idempotency-Key")
        if not idempotency_key:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Idempotency-Key header is required for this endpoint"
            )

        db = SessionLocal()
        try:
            # Check for existing key
            existing_key = self._get_existing_key(db, idempotency_key, request.url.path)
            if existing_key:
                if existing_key.response_data:
                    return self._build_response(existing_key.response_data)
            else:
                # Create new idempotency key
                self._create_idempotency_key(db, idempotency_key, request.url.path)

            # Process the request
            response = await call_next(request)
            
            # Store the response
            self._store_response(db, idempotency_key, response)
            
            return response

        finally:
            db.close()

    def _should_check_idempotency(self, request: Request) -> bool:
        """Check if the request should be idempotent"""
        idempotent_endpoints = {
            "/api/registration/register": ["POST"],
            "/api/payment/create": ["POST"],
            "/api/orders/create": ["POST"]
        }
        
        return (
            request.url.path in idempotent_endpoints
            and request.method in idempotent_endpoints[request.url.path]
        )

    def _get_existing_key(self, db: Session, key: str, endpoint: str) -> IdempotencyKey:
        """Get existing idempotency key if it exists and is not expired"""
        return db.query(IdempotencyKey).filter(
            IdempotencyKey.key == key,
            IdempotencyKey.endpoint == endpoint,
            IdempotencyKey.expires_at > datetime.utcnow()
        ).first()

    def _create_idempotency_key(self, db: Session, key: str, endpoint: str):
        """Create new idempotency key"""
        expires_at = datetime.utcnow() + timedelta(hours=self.expires_in_hours)
        idempotency_key = IdempotencyKey(
            key=key,
            endpoint=endpoint,
            expires_at=expires_at
        )
        db.add(idempotency_key)
        db.commit()

    def _store_response(self, db: Session, key: str, response: Response):
        """Store response data"""
        idempotency_key = db.query(IdempotencyKey).filter(
            IdempotencyKey.key == key
        ).first()
        
        if idempotency_key and hasattr(response, 'body'):
            # Get response body
            try:
                body = json.loads(response.body.decode())
                idempotency_key.response_data = body
                db.commit()
            except:
                pass  # Ignore if response cannot be stored

    def _build_response(self, data: dict):
        """Build response from stored data"""
        from fastapi.responses import JSONResponse
        return JSONResponse(content=data)
