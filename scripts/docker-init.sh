#!/bin/bash

set -e # exit if you're a retard

# Get the absolute path to the directory where the script is located.
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ENV_FILE="${SCRIPT_DIR}/../.env"

NETWORKS=(
	"caddy-network"
	"gluetun-network"
)

VOLUMES=(
	"caddy-volume"
	"chhoto-volume"
	"cleanuparr-volume"
	"deemix-volume"
	"gluetun-volume"
	"jellyfin-volume"
	"lidarr-volume"
	"profilarr-volume"
	"prowlarr-volume"
	"qbittorrent-volume"
	"radarr-volume"
	"readarr-volume"
	"slskd-volume"
	"socket-proxy-volume"
	"sonarr-volume"
	"soularr-volume"
	"vaultwarden-volume"
)

# Use sudo if not ran as root.
SUDO=''
if [ "$(id -u)" -ne 0 ]; then
	SUDO='sudo'
	echo "Script not run as root. Using sudo for privileged commands."
fi

# Sources the env file.
if [ -f "$ENV_FILE" ]; then
	echo "Sourcing environment variables from ${ENV_FILE}."
	set -a
	# shellcheck disable=SC1090
	. "$ENV_FILE"
	set +a
else
	echo "Error: ${ENV_FILE} not found moron."
	exit 1
fi

# Creates directories.
echo "Creating directory structure..."
mkdir -p \
	"${DOWNLOADS_PATH}"/{deemix,soulseek,torrents/{sonarr,readarr,radarr,lidarr,.incomplete,.torrent-files}} \
	"${MEDIA_LIBRARY_PATH}"/{anime,audiobooks,books,comics,manga,movies,tv-shows} \
	"${OPENCLOUD_DATA_PATH}"

# Applies permissions.
echo "Setting permissions on host directories..."
$SUDO chown -R "${PUID}:${PGID}" "${DOWNLOADS_PATH}" "${MEDIA_LIBRARY_PATH}" "${OPENCLOUD_DATA_PATH}"
echo "Directories created successfully."

# Docker network setup.
echo "Creating Docker networks..."
for network in "${NETWORKS[@]}"; do
	docker network create "$network" || true
done

docker network create --internal socket-proxy-network || true

# Docker volume setup.
echo "Creating Docker volumes..."
for volume in "${VOLUMES[@]}"; do
	docker volume create "$volume" || true
done

echo "Setup complete!"
