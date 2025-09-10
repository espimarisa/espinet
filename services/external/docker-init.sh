#!/bin/sh

# Creates the required networks.
docker network create external-network
docker network create socket-proxy-network

# Creates the required volumes.
docker volume create caddy-volume
docker volume create jellyfin-volume
docker volume create opencloud-volume
