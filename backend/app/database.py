from sqlalchemy import create_engine, inspect
from sqlalchemy.orm import sessionmaker
from .models import Base
from dotenv import load_dotenv
import os

load_dotenv()

# Lấy thông tin kết nối từ biến môi trường
DATABASE_URL = f"postgresql://{os.getenv('DB_USER')}:{os.getenv('DB_PASSWORD')}@{os.getenv('DB_HOST')}:{os.getenv('DB_PORT')}/{os.getenv('DB_NAME')}"

# Tạo engine với các cấu hình tối ưu
engine = create_engine(
    DATABASE_URL,
    pool_size=5,
    max_overflow=10,
    pool_pre_ping=True,
    pool_recycle=300,  # Recycle connections every 5 minutes
)

# Tạo session factory
SessionLocal = sessionmaker(
    bind=engine,
    autocommit=False,
    autoflush=False
)

# Dependency để lấy database session
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

def check_table_exists(table_name: str) -> bool:
    """Check if a table exists in the database"""
    inspector = inspect(engine)
    return table_name in inspector.get_table_names()

def ensure_pending_users_table():
    """Ensure pending_users table exists"""
    if not check_table_exists("pending_users"):
        from .models.pending_user_model import PendingUser
        Base.metadata.create_all(bind=engine, tables=[PendingUser.__table__])

# Export các components cần thiết
__all__ = ['engine', 'SessionLocal', 'get_db', 'ensure_pending_users_table']
