#!/bin/bash

# Configuration Variables
NETWORK_NAME="drupal-net"
DB_CONTAINER_NAME="drupal-mysql"
DRUPAL_CONTAINER_NAME="drupal-server"
DB_NAME="drupaldb"
DB_ROOT_PASSWORD="my-secret-pw"
DB_USER="drupaluser"
DB_PASSWORD="drupalpass"

echo "=== [1/3] Checking and creating Docker network ($NETWORK_NAME)... ==="
if ! docker network ls | grep -q "$NETWORK_NAME"; then
    docker network create "$NETWORK_NAME"
    echo "Network created successfully."
else
    echo "Network $NETWORK_NAME already exists, skipping."
fi

echo "=== [2/3] Downloading and starting MySQL container... ==="
docker run -d \
    --name "$DB_CONTAINER_NAME" \
    --network "$NETWORK_NAME" \
    -p 3306:3306 \
    -e MYSQL_ROOT_PASSWORD="$DB_ROOT_PASSWORD" \
    -e MYSQL_DATABASE="$DB_NAME" \
    -e MYSQL_USER="$DB_USER" \
    -e MYSQL_PASSWORD="$DB_PASSWORD" \
    mysql:latest

echo "=== [3/3] Downloading and starting Drupal container... ==="
docker run -d \
    --name "$DRUPAL_CONTAINER_NAME" \
    --network "$NETWORK_NAME" \
    -p 8080:80 \
    drupal:latest

echo "=========================================================="
echo "Setup completed successfully!"
echo "Please wait ~30 seconds for MySQL to initialize."
echo "Then access the site at: http://localhost:8080"
echo "=========================================================="
