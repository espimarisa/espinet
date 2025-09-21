#!/bin/bash

###############################################################################
# This script scans for Featurettes folders, sometimes included in BD or DVD  #
# releases of movies, and will import them when importing movies to Radarr.   #
# Configure Radarr to run this script post-import, wherever it's mounted at.  #
# shellcheck disable=SC2154													  #
###############################################################################

# Source folder path from Radarr's internal variable.
source_path="$radarr_moviefile_sourcepath"

# Extracts the movie filename from the import path.
movie_filename="${radarr_moviefile_path##*/}"

# Constructs the source "Featurettes" folder path.
featurettes_source_path="$source_path/$movie_filename/Featurettes"

# Construct the destination "Featurettes" folder path.
featurettes_dest_path="$radarr_moviefile_path/Featurettes"

# Checks to see if the source "Featurettes" folder exists.
if [ -d "$featurettes_source_path" ]; then
	# Copy the "Featurettes" folder to the import folder.
	cp -rf "$featurettes_source_path" "$featurettes_dest_path"
	echo "Featurettes folder copied to: $featurettes_dest_path"
	exit 0
else
	echo "No Featurettes folder was found, not copying."
	exit 0
fi
