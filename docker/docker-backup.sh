#!/bin/bash

set -eo pipefail

# Gets the absolute path to the script's directory.
TIMESTAMP=$(date +"%Y-%m-%d_%H%M%S")
SCRIPT_DIRECTORY="$(cd "$(dirname "$0")" && pwd)"
ENV_FILE="${SCRIPT_DIRECTORY}/../.env"

# Loads environment variables from .env file.
if [ -f "$ENV_FILE" ]; then
	echo "Sourcing environment variables from ${ENV_FILE}."
	set -a
	# shellcheck disable=SC1090
	. "$ENV_FILE"
	set +a
else
	echo "Error: ${ENV_FILE} not found." >&2
	exit 1
fi

# Verify that all required environment variables are set.
REQUIRED_VARS=(
	"BACKUP_STAGING_DIRECTORY"
	"BACKUP_CONFIG_DIRECTORY"
	"RCLONE_REMOTE"
	"RCLONE_REMOTE_DIRECTORY"
)

for var in "${REQUIRED_VARS[@]}"; do
	if [ -z "${!var}" ]; then
		echo "Error: Required environment variable ${var} is not set in .env file." >&2
		exit 1
	fi
done

# This function will run automatically when the script exits for any reason.
function cleanup() {
	echo "Executing cleanup and restarting services..."
	docker compose --project-directory "${BACKUP_CONFIG_DIRECTORY}" up -d --remove-orphans
	echo "Services have been restarted."
	echo "Removing local staging directory: ${STAGING_DIR}"
	rm -rf "${STAGING_DIR}"
	echo "Backup process finished."
}
trap cleanup EXIT INT TERM

# Creates a timestamped staging directory for this specific backup.
echo "Starting Docker backup process (${TIMESTAMP})..."
STAGING_DIR="${BACKUP_STAGING_DIRECTORY}/${TIMESTAMP}"
mkdir -p "${STAGING_DIR}"

# Stops currently running services to ensure data consistency.
echo "Stopping services..."
docker compose --project-directory "${BACKUP_CONFIG_DIRECTORY}" stop

# 1. Back up the configuration files.
echo "Backing up configuration files..."
tar -czf "${STAGING_DIR}/config_${TIMESTAMP}.tar.gz" -C "$(dirname "${BACKUP_CONFIG_DIRECTORY}")" "$(basename "${BACKUP_CONFIG_DIRECTORY}")"

# 2. Back up each Docker volume.
echo "Backing up Docker volumes..."
VOLUMES_TO_BACKUP=(
	"caddy-volume"
	"chhoto-volume"
	"cleanuparr-volume"
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
	"sonarr-volume"
	"soularr-volume"
	"thelounge-volume"
	"vaultwarden-volume"
)

for volume in "${VOLUMES_TO_BACKUP[@]}"; do
	echo " > Backing up volume: ${volume}"
	docker run --rm \
		-v "${volume}:/data:ro" \
		-v "${STAGING_DIR}:/backup" \
		alpine \
		tar -czf "/backup/${volume}_${TIMESTAMP}.tar.gz" -C /data .
done

# 3. Upload backups to the remote destination.
RCLONE_FULL_PATH="${RCLONE_REMOTE}:${RCLONE_REMOTE_DIRECTORY}/$(date +"%Y-%m")"
echo "Uploading backups to ${RCLONE_FULL_PATH}..."
rclone copy "${STAGING_DIR}" "${RCLONE_FULL_PATH}" --progress
echo "Backup completed successfully!"
