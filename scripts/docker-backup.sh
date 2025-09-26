#!/bin/bash

set -e

# Gets the absolute path to the directory.
SCRIPT_DIRECTORY="$(cd "$(dirname "$0")" && pwd)"
ENV_FILE="${SCRIPT_DIRECTORY}/../.env"

# Loads environment variables.
if [ -f "$ENV_FILE" ]; then
	echo "Sourcing environment variables from ${ENV_FILE}."
	set -a
	# shellcheck disable=SC1090
	. "$ENV_FILE"
	set +a
else
	echo "Error: ${ENV_FILE} not found."
	exit 1
fi

# Creates a clean staging directory.
echo "Starting Docker backup process..."
rm -rf "${BACKUP_STAGING_DIRECTORY}"
mkdir -p "${BACKUP_STAGING_DIRECTORY}"

# Goes to the config directory to run compose commands.
cd "${BACKUP_CONFIG_DIRECTORY}"

# Stops currently running services.
echo "Stopping services..."
docker compose stop

# 1. Back up the configuration files.
echo "Backing up configuration files..."
tar -czf "${BACKUP_STAGING_DIRECTORY}/config_$(date +"%Y-%m-%d").tar.gz" -C "$(dirname "${BACKUP_CONFIG_DIRECTORY}")" "$(basename "${BACKUP_CONFIG_DIRECTORY}")"

# 2. Back up each Docker volume.
echo "Backing up Docker volumes..."
VOLUMES_TO_BACKUP=(
	"caddy-volume"
	"chhoto-volume"
	"cleanuparr-volume"
	"deemix-volume"
	"gluetun-volume"
	"jellyfin-volume"
	"lidarr-volume"
	"opencloud-volume"
	"profilarr-volume"
	"prowlarr-volume"
	"qbittorrent-volume"
	"radarr-volume"
	"readarr-volume"
	"slskd-volume"
	"socket-proxy-volume"
	"sonarr-volume"
	"soularr-volume"
	"thelounge-volume"
	"vaultwarden-volume"
)

# Backs up each volume.
for volume in "${VOLUMES_TO_BACKUP[@]}"; do
	echo " > Backing up volume: ${volume}"
	docker run --rm \
		-v "${volume}:/data:ro" \
		-v "${BACKUP_STAGING_DIRECTORY}:/backup" \
		alpine \
		tar -czf "/backup/${volume}_$(date +"%Y-%m-%d").tar.gz" -C /data .
done

# Restarts services.
echo "Restarting services..."
# docker compose up -d

# Construct the full remote path, including a monthly subfolder.
RCLONE_FULL_PATH="${RCLONE_REMOTE}:${RCLONE_REMOTE_DIRECTORY}/$(date +"%Y-%m")"

# Uploads backups.
echo "Uploading backups to ${RCLONE_FULL_PATH}..."
rclone copy "${BACKUP_STAGING_DIRECTORY}" "${RCLONE_FULL_PATH}" --progress

# Cleans up backups.
echo "Cleaning up local backup files..."
rm -rf "${BACKUP_STAGING_DIRECTORY}"
echo "Backup process completed successfully!"
