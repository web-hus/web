@echo off
cd /d %~dp0..
python scripts/backup_db.py >> logs/backup.log 2>&1
