#!/bin/bash

# Configuration Variables
NETWORK_NAME="drupal-net"
DB_CONTAINER_NAME="drupal-mysql"
DRUPAL_CONTAINER_NAME="drupal-server"

echo "=== Starting Environment Cleanup ==="

echo "Removing containers ($DRUPAL_CONTAINER_NAME, $DB_CONTAINER_NAME)..."
docker rm -f "$DRUPAL_CONTAINER_NAME" "$DB_CONTAINER_NAME" 2>/dev/null

echo "Removing network ($NETWORK_NAME)..."
docker network rm "$NETWORK_NAME" 2>/dev/null

echo "Removing unused Docker volumes..."
docker volume prune -f

echo "=========================================================="
echo "Cleanup completed successfully! Environment is clean."
echo "=========================================================="
