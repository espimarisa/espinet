#!/bin/bash

set -e

echo "Pulling latest git commits..."
git pull

echo "Pulling latest Docker images..."
docker compose pull

echo "Restarting services with new images..."
docker compose up -d

echo "Cleaning up old images..."
docker image prune -f

echo "Update complete!"
