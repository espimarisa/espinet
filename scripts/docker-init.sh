#!/bin/sh

# Creates networks.
docker network create caddy-network
docker network create gluetun-network
docker network create infra-network

# Creates volumes.
docker volume create cleanuparr-volume
docker volume create deemix-volume
docker volume create dozzle-volume
docker volume create gluetun-volume
docker volume create jellyfin-cache-volume
docker volume create jellyfin-volume
docker volume create lidarr-volume
docker volume create opencloud-volume
docker volume create profilarr-volume
docker volume create prowlarr-volume
docker volume create qbittorrent-volume
docker volume create radarr-volume
docker volume create readarr-volume
docker volume create sonarr-volume
docker volume create uptime-kuma-volume
docker volume create vaultwarden-volume
