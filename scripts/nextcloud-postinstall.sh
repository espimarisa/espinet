#!/bin/sh

# This sets the Nextcloud maintenence window to a non-peak hour (5AM).
docker exec -it nextcloud sh -c "php occ config:system:set maintenance_window_start --value=5"

# This allows for proper Mimetype migrations.
docker exec -it nextcloud sh -c "php occ maintenance:repair --include-expensive"
