# espinet

Compose setups, configuration files, and scripts taken from my homelab setup.

## Setup

```bash
# i'm lazy and don't want to make a script right now
# obviously replace /storage to the storage path, mine is /storage. zfs rocks 8)

# create required docker volumes
docker volume create bazarr-volume
docker volume create bookshelf-volume
docker volume create bookshelf-volume
docker volume create caddy-volume
docker volume create checkmate-db-volume
docker volume create cleanuparr-volume
docker volume create configarr-volume
docker volume create deemix-volume
docker volume create gluetun-volume
docker volume create homarr-volume
docker volume create jellyfin-cache-volume
docker volume create jellyfin-volume
docker volume create lidarr-volume
docker volume create opencloud-volume
docker volume create picard-volume
docker volume create profilarr-volume
docker volume create prowlarr-volume
docker volume create qbittorrent-volume
docker volume create radarr-volume
docker volume create socket-proxy-volume
docker volume create sonarr-volume
docker volume create thelounge-volume

# create required docker networks
docker network create -d bridge external-network
docker network create -d bridge gluetun-network
docker network create -d bridge internal-network
docker network create -d bridge media-network

# create required host directories
mkdir -p /storage/media-library
mkdir -p /storage/downloads

# create media library directory structure
mkdir -p /storage/media-library/anime
mkdir -p /storage/media-library/audiobooks
mkdir -p /storage/media-library/books
mkdir -p /storage/media-library/comics
mkdir -p /storage/media-library/manga
mkdir -p /storage/media-library/movies
mkdir -p /storage/media-library/music
mkdir -p /storage/media-library/tv-shows

# create download structure
mkdir -p /storage/downloads/torrents
mkdir -p /storage/downloads/torrents/.dot-torrents # complete .torrent file backups
mkdir -p /storage/downloads/torrents/.incomplete # incomplete downloads
mkdir -p /storage/downloads/torrents/.monitored # any torrents placed here will be monitored once configured
mkdir -p /storage/downloads/bookshelf
mkdir -p /storage/downloads/deemix
mkdir -p /storage/downloads/lidarr
mkdir -p /storage/downloads/radarr
mkdir -p /storage/downloads/sonarr

```

## License

[zlib][license]

[license]: LICENSE.md "zlib"
