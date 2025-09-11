#!/bin/sh

# Creates networks.
docker network create cloud-network
docker network create external-network
docker network create gluetun-network
docker network create media-network
docker network create socket-proxy-network

# Creates volumes.
docker volume create cleanuparr-volume
docker volume create deemix-volume
docker volume create gluetun-volume
docker volume create jellyfin-volume
docker volume create lidarr-volume
docker volume create opencloud-volume
docker volume create profilarr-volume
docker volume create prowlarr-volume
docker volume create qbittorrent-volume
docker volume create radarr-volume
docker volume create readarr-volume
docker volume create sonarr-volume
