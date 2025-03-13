from os.path import splitdrive, split as dirsplit, basename, isdir
import sys
import shlex
import subprocess
from time import sleep
path = sys.argv[1]
category = sys.argv[2]

# qBittorrent categories allowed to create hardlinks
# be sure you create these first!
allowed_categories = [
    "anime",
    "anime-movies",
    "audiobooks",
    "books",
    "comics",
    "manga",
    "movies",
    "music",
    "tv"
]

if category not in allowed_categories:
    exit()

# folders allowed to have hardlinks put in
# these are the download folders inside of qbittorrent
allowed_folders = [
    "anime",
    "anime-movies",
    "audiobooks",
    "books",
    "comics",
    "manga",
    "movies",
    "music",
    "tv"
]

# final destination folders
# be sure they exist and match your file structure
# mine is hardcoded to be /mnt/md0/medialibrary
# which is mapped to /storage/medialibrary inside of docker
dest_folders = [
    "/storage/medialibrary/anime",
    "/storage/medialibrary/anime-movies",
    "/storage/medialibrary/audiobooks",
    "/storage/medialibrary/books",
    "/storage/medialibrary/comics",
    "/storage/medialibrary/manga",
    "/storage/medialibrary/movies",
    "/storage/medialibrary/music",
    "/storage/medialibrary/tv"
]

# creates hardlinks
drive = splitdrive(path)[0]
folder = dirsplit(path)[0].split("/")[-1]  # this is shit code ngl
base = basename(path)
print(folder)
for x in zip(allowed_folders, dest_folders):
    if folder in x[0]:
        print(f"this should go to: {x[1]}")
        print(f"folder: {folder}")
        command = "cp -lRf "
        command += f'"{path}" "{x[1]}"'
        subprocess.run(shlex.split(command))
        print(f"is this correct? {command}")
