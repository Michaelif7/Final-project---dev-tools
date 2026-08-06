#!/bin/bash

# Configuration Variables
DB_CONTAINER_NAME="drupal-mysql"
DB_ROOT_PASSWORD="my-secret-pw"
BACKUP_DIR="./backups"
BACKUP_FILE="$BACKUP_DIR/my-drupal.backup.sql.gz"

echo "=== Starting Drupal Database Backup ==="

# Create backups directory if it does not exist
mkdir -p "$BACKUP_DIR"

echo "Dumping and compressing MySQL databases from container ($DB_CONTAINER_NAME)..."
docker exec "$DB_CONTAINER_NAME" sh -c "exec mysqldump --all-databases -uroot -p'$DB_ROOT_PASSWORD'" | gzip > "$BACKUP_FILE"

# Check if the backup command succeeded
if [ $? -eq 0 ]; then
    echo "=========================================================="
    echo "Backup completed successfully!"
    echo "Backup file saved to: $BACKUP_FILE"
    echo "File size:"
    ls -lh "$BACKUP_FILE"
    echo "=========================================================="
else
    echo "Error: Database backup failed."
    exit 1
fi
