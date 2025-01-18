from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from .database import engine, ensure_pending_users_table
from .models import Base
from .middleware.idempotency import IdempotencyMiddleware
from .routers import api_router
from .routers.registration import router as registration_router
from fastapi.openapi.utils import get_openapi
from fastapi.responses import JSONResponse
import yaml
import json
from fastapi import Response

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

def custom_openapi():
    if app.openapi_schema:
        return app.openapi_schema
    openapi_schema = get_openapi(
        title="Restaurant Management System API",
        version="1.0.0",
        description="This is a Restaurant Management System API documentation",
        routes=app.routes,
    )
    app.openapi_schema = openapi_schema
    return app.openapi_schema

app.openapi = custom_openapi

@app.get("/api/openapi.json", include_in_schema=False)
async def get_openapi_json():
    """Get OpenAPI schema in JSON format"""
    json_schema = custom_openapi()
    return Response(
        content=json.dumps(json_schema, indent=2),
        media_type="application/json",
        headers={
            "Content-Disposition": "attachment; filename=openapi.json"
        }
    )

@app.get("/api/openapi.yaml", include_in_schema=False)
async def get_openapi_yaml():
    """Get OpenAPI schema in YAML format"""
    json_schema = custom_openapi()
    yaml_schema = yaml.dump(json_schema, default_flow_style=False)
    return Response(
        content=yaml_schema,
        media_type="text/yaml",
        headers={
            "Content-Disposition": "attachment; filename=openapi.yaml"
        }
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

app.include_router(api_router, prefix="/api")

app.include_router(registration_router, prefix="/api")

@app.get("/")
async def read_root():

    return {
        "message": "Welcome to Restaurant Management System API",
        "version": "1.0.0",
        "docs": "/api/docs"
    }
