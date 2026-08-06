#!/bin/bash

# Configuration Variables
DB_CONTAINER_NAME="drupal-mysql"
DRUPAL_CONTAINER_NAME="drupal-server"
DB_ROOT_PASSWORD="my-secret-pw"
BACKUP_FILE="./backups/my-drupal.backup.sql.gz"

echo "=== Starting Drupal Database Restore ==="

# Check if backup file exists
if [ ! -f "$BACKUP_FILE" ]; then
    echo "Error: Backup file $BACKUP_FILE not found!"
    echo "Please run backup.sh first."
    exit 1
fi

echo "Restoring database from: $BACKUP_FILE..."
gunzip < "$BACKUP_FILE" | docker exec -i "$DB_CONTAINER_NAME" sh -c "exec mysql -uroot -p'$DB_ROOT_PASSWORD' --force"

# Check if restore command succeeded
if [ $? -eq 0 ]; then
    echo "Database restored successfully."
    echo "Restarting Drupal container to apply changes..."
    docker restart "$DRUPAL_CONTAINER_NAME"
    echo "=========================================================="
    echo "Restore completed successfully! Site is ready."
    echo "=========================================================="
else
    echo "Error: Database restore failed."
    exit 1
fi

