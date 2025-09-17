#!/usr/bin/env python3

# espi's crappy little backup script
# this script backs up critical data to google drive
# rclone must be installed and configured on your system locally

# export RCLONE_REMOTE_NAME="gdrive"
# export GDRIVE_BACKUP_DIR="homelab-backups"
# export BACKUP_PATH_DOCKER="/var/lib/docker/volumes"
# export BACKUP_PATH_BITWARDEN="/storage/vaultwarden"
# export BACKUP_PATH_OPENCLOUD="/storage/opencloud"
# export BACKUP_PATH_THELOUNGE="/storage/thelounge"

from subprocess import CompletedProcess

import os
import subprocess
import sys
from datetime import datetime

# Gets the configured remote path, directory, and prefix.
BACKUP_PATH_PREFIX = "BACKUP_PATH_"
GDRIVE_BACKUP_DIR: str = os.getenv("GDRIVE_BACKUP_DIR", "backups")
RCLONE_REMOTE_NAME: str | None = os.getenv("RCLONE_REMOTE_NAME")

def main() -> None:
    print("Starting backup...")

    # Checks to see if the remote name is set.
    if not RCLONE_REMOTE_NAME:
        print("RCLONE_REMOTE_NAME is not configured in your environment.")
        sys.exit(1)

    # Gets a list of directories to backup.
    source_paths: list[str] = []
    for key, value in os.environ.items():
        # only backup paths starting with the prefix
        if key.startswith(BACKUP_PATH_PREFIX):
            if os.path.isdir(s=value):
                source_paths.append(value)
                print(f"Found source directory: {value}.")
            else:
                print(f"Skipping {value} for {key}, invalid directory.")

    # Do not continue if no valid paths were found.
    if not source_paths:
        print("No backup paths were found.")
        sys.exit(0)

    # Creates a timestampped directory.
    timestamp: str = datetime.now().strftime(format="%Y-%m-%d_%H-%M-%S")
    base_destination_path: str = f"{RCLONE_REMOTE_NAME}:{GDRIVE_BACKUP_DIR}/{timestamp}"
    print(f"\nBackups will be stored in: {base_destination_path}.")
    errors = 0
    for path in source_paths:
        # Uses the last part of the path as the destination subfolder name.
        destination_name: str = os.path.basename(os.path.normpath(path))
        full_destination: str = f"{base_destination_path}/{destination_name}"
        print(f"\nBacking up {path} to {full_destination}...")

        # Constructs the rclone command. copy does not delete files, sync does.
        command: list[str] = [
            "rclone",
            "copy",
            path,
            full_destination,
            "--progress",
            "--create-empty-src-dirs",
        ]

        try:
            # Runs the command.
            process: CompletedProcess[str] = subprocess.run(command, check=True, capture_output=True, text=True)
            print(f"Successfully backed up {path}.")

            # Prints stdout for more verbose logging.
            print(process.stdout)
        except subprocess.CalledProcessError as e:
            print(f"Error backing up {path}.")
            print(f"   {e.returncode}")
            print(f"   {e.stderr.strip()}")  # pyright: ignore[reportAny] look man i hate python
            errors += 1
        except FileNotFoundError:
            print("Error: rclone not found or in system PATH. The fuck wrong with you")
            sys.exit(1)

    if errors == 0:
        print("Backups completed successfully!")
    else:
        print(f"Backup process completed with {errors} errors.")
        sys.exit(1)

# python is not a real language lmao
if __name__ == "__main__":
    main()
