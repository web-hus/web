import os
import subprocess
from pathlib import Path
import argparse

def restore_database(backup_file: str):
    """Restore PostgreSQL database from backup"""
    try:
        # Load environment variables
        db_name = os.getenv("DB_NAME", "web")
        db_user = os.getenv("DB_USER", "postgres")
        db_password = os.getenv("DB_PASSWORD", "postgre")
        
        # Check if backup file exists
        backup_path = Path(backup_file)
        if not backup_path.exists():
            print(f"Backup file not found: {backup_file}")
            return
        
        # Set PGPASSWORD environment variable
        os.environ["PGPASSWORD"] = db_password
        
        # Drop existing database connections
        subprocess.run([
            "psql",
            "-U", db_user,
            "-d", "postgres",
            "-c", f"SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = '{db_name}'"
        ], check=True)
        
        # Drop and recreate database
        subprocess.run([
            "psql",
            "-U", db_user,
            "-d", "postgres",
            "-c", f"DROP DATABASE IF EXISTS {db_name}"
        ], check=True)
        
        subprocess.run([
            "psql",
            "-U", db_user,
            "-d", "postgres",
            "-c", f"CREATE DATABASE {db_name}"
        ], check=True)
        
        # Restore from backup
        subprocess.run([
            "pg_restore",
            "-U", db_user,
            "-d", db_name,
            str(backup_path)
        ], check=True)
        
        print(f"Database restored successfully from: {backup_file}")
        
    except subprocess.CalledProcessError as e:
        print(f"Error restoring database: {e}")
    except Exception as e:
        print(f"Unexpected error: {e}")
    finally:
        # Clear PGPASSWORD
        os.environ.pop("PGPASSWORD", None)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Restore PostgreSQL database from backup")
    parser.add_argument("backup_file", help="Path to backup file")
    args = parser.parse_args()
    
    restore_database(args.backup_file)
