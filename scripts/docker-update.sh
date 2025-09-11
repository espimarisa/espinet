#!/bin/sh

# Stops currently running containers.
echo "Stopping containers..."
docker compose stop

# Fetches latest commit and images.
echo "Pulling latest changes..."
git pull
docker compose pull -f
echo "Finished updating."
