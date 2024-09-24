#!/bin/bash

# Creates volumes
docker volume create redis-volume
docker volume create nextcloud_aio_mastercontainer
docker volume create searxng-volume
docker volume create homepage-volume
docker volume create qbittorrentvpn-volume
docker volume create radarr-volume
docker volume create sonarr-volume
docker volume create lidarr-volume
docker volume create prowlarr-volume
docker volume create readarr-volume
docker volume create recyclarr-volume
docker volume create jellyfin-volume
docker volume create deemix-volume

# Creates network
docker network create global-network
docker network create download-network

# Makes a temporary wireguard config
touch ../qbittorrent-vpn/wireguard/wg0.conf
