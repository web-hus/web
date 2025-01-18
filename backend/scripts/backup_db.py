import os
import subprocess
from datetime import datetime
import shutil
from pathlib import Path

def create_backup_directory():
    # Tạo thư mục backup trong thư mục gốc của project
    backup_dir = Path(__file__).parent.parent / "backups"
    backup_dir.mkdir(exist_ok=True)
    return backup_dir

def cleanup_old_backups(backup_dir: Path, keep_days: int = 30):
    current_time = datetime.now()
    for backup_file in backup_dir.glob("*.dump"):
        file_time = datetime.fromtimestamp(backup_file.stat().st_mtime)
        if (current_time - file_time).days > keep_days:
            backup_file.unlink()

def backup_database():
    """Backup PostgreSQL database"""
    try:
        # Load environment variables
        db_name = os.getenv("DB_NAME", "web")
        db_user = os.getenv("DB_USER", "postgres")
        db_password = os.getenv("DB_PASSWORD", "postgre")
        
        # Create backup directory
        backup_dir = create_backup_directory()
        
        # Generate backup filename with timestamp
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        backup_file = backup_dir / f"backup_{timestamp}.dump"
        
        # Set PGPASSWORD environment variable
        os.environ["PGPASSWORD"] = db_password
        
        # Create backup using pg_dump
        subprocess.run([
            "pg_dump",
            "-U", db_user,
            "-d", db_name,
            "-Fc",  # Custom format (compressed)
            "-f", str(backup_file)
        ], check=True)
        
        print(f"Backup created successfully: {backup_file}")
        
        # Cleanup old backups
        cleanup_old_backups(backup_dir)
        
    except subprocess.CalledProcessError as e:
        print(f"Error creating backup: {e}")
    except Exception as e:
        print(f"Unexpected error: {e}")
    finally:
        # Clear PGPASSWORD
        os.environ.pop("PGPASSWORD", None)

if __name__ == "__main__":
    backup_database()
