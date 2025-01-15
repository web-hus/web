from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from .database import engine
from .models import Base
from .middleware.rate_limiter import RateLimiter
from .routers import api_router

# Tạo bảng nếu chưa tồn tại
Base.metadata.create_all(bind=engine)

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

# CORS configuration
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include routers with /api prefix
app.include_router(api_router, prefix="/api")

@app.get("/")
def read_root():
    return {"message": "Welcome to Restaurant Management System API"}
