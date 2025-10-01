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
	"APPDATA_PATH"
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
	echo "Executing cleanup and restarting OpenCloud service..."
	# Assumes opencloud is in your main compose file; adjust if it's separate.
	docker compose -f "${BACKUP_CONFIG_DIRECTORY}/compose.yml" up -d opencloud
	echo "OpenCloud service has been restarted."
	echo "Large data backup process finished."
}
trap cleanup EXIT INT TERM

echo "Starting large data backup process (${TIMESTAMP})..."

# Stop the OpenCloud container to ensure data consistency during backup.
echo "Stopping OpenCloud service..."
docker compose -f "${BACKUP_CONFIG_DIRECTORY}/compose.yml" stop opencloud

# Define remote paths for the backup.
REMOTE_BASE_PATH="${RCLONE_REMOTE}:${RCLONE_REMOTE_DIRECTORY}/opencloud"
REMOTE_CURRENT_PATH="${REMOTE_BASE_PATH}/current"
REMOTE_ARCHIVE_PATH="${REMOTE_BASE_PATH}/archive/${TIMESTAMP}"

# Perform an incremental backup with versioning.
echo "Syncing data from ${APPDATA_PATH}/opencloud to ${REMOTE_CURRENT_PATH}..."
echo "Older file versions will be moved to: ${REMOTE_ARCHIVE_PATH}"

rclone copy \
	"${APPDATA_PATH}/opencloud" \
	"${REMOTE_CURRENT_PATH}" \
	--backup-dir "${REMOTE_ARCHIVE_PATH}" \
	--progress \
	--transfers=16

echo "Large data backup completed successfully!"
