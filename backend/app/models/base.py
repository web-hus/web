from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()

# Re-export Base để các models khác có thể import từ đây
__all__ = ['Base']
