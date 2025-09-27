#!/bin/bash

set -eo pipefail

echo "Pulling latest changes from git..."
git pull

echo "Pulling latest Docker images..."
docker compose pull

echo "Recreating containers and applying updates..."
docker compose up -d --remove-orphans

echo "Cleaning up dangling Docker images..."
docker image prune -f

echo "Update complete!"
