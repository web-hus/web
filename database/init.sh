#!/bin/bash
set -e

# Start the default PostgreSQL entrypoint script
docker-entrypoint.sh postgres &

# Wait for PostgreSQL to be ready
echo "Waiting for PostgreSQL to start..."
until pg_isready -U "$POSTGRES_USER"; do
  sleep 1
done
echo "PostgreSQL is ready."

# Restore the database
echo "Restoring database from backup..."
pg_restore --verbose --clean --no-owner --if-exists -U "$POSTGRES_USER" -d "$POSTGRES_DB" /docker-entrypoint-initdb.d/thuan_update_db_new.backup

# Keep the container running
wait
