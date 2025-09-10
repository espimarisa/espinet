#!/bin/sh

# Creates the required networks.
docker network create gluetun-network

# Creates the required volumes.
docker volume create cleanuparr-volume
docker volume create deemix-volume
docker volume create gluetun-volume
docker volume create lidarr-volume
docker volume create profilarr-volume
docker volume create prowlarr-volume
docker volume create qbittorrent-volume
docker volume create radarr-volume
docker volume create readarr-volume
docker volume create sonarr-volume
