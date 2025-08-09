#!/bin/sh

# Creates volumes.
docker volume create caddy-volume
docker volume create gluetun-volume
docker volume create jellyfin-cache-volume
docker volume create jellyfin-volume
docker volume create lidarr-volume
docker volume create qbittorrent-volume
docker volume create radarr-volume
docker volume create sonarr-volume

# Creates networks.
docker network create -d bridge caddy-network
docker network create -d bridge gluetun-network
docker network create -d bridge media-network

exit
