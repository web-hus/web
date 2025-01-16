from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from .database import engine, ensure_pending_users_table
from .models import Base
from .middleware.rate_limiter import RateLimiter
from .middleware.idempotency import IdempotencyMiddleware
from .routers import api_router
from .routers.registration import router as registration_router

# Tạo bảng nếu chưa tồn tại
Base.metadata.create_all(bind=engine)

# Đảm bảo bảng pending_users tồn tại
ensure_pending_users_table()

app = FastAPI(
    title="Restaurant Management System",
    description="Backend API for Restaurant Management System",
    version="1.0.0",
    docs_url="/api/docs",
    redoc_url="/api/redoc"
)

# Add rate limiter middleware
app.add_middleware(
    RateLimiter,
    requests_per_minute=60
)

# Add idempotency middleware
app.add_middleware(IdempotencyMiddleware)

# CORS configuration
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include API router
app.include_router(api_router, prefix="/api")

# Add registration router
app.include_router(registration_router, prefix="/api")

@app.get("/")
async def read_root():
    """
    Root endpoint - Health check and welcome message
    """
    return {
        "status": "healthy",
        "message": "Welcome to Restaurant Management System API",
        "version": "1.0.0",
        "docs": "/api/docs"
    }
