#!/bin/bash
set -e

echo "Waiting for PostgreSQL to start..."
until pg_isready -U "$POSTGRES_USER"; do
  sleep 1
done
echo "PostgreSQL is ready."

# Restore the database
if [ -f "/docker-entrypoint-initdb.d/thuan_update_db_new.backup" ]; then
  echo "Restoring database from backup..."
  pg_restore --verbose --clean --no-owner --if-exists -U "$POSTGRES_USER" -d "$POSTGRES_DB" /docker-entrypoint-initdb.d/thuan_update_db_new.backup
else
  echo "Backup file not found. Skipping restore."
fi

echo "Initialization completed."
