# espinet

Compose setups, configuration files, and various scripts used in my homelab ("espi@net").

## Services

- [Caddy](./apps/caddy/compose.yml) - Web server and reverse proxy.
- [Cloudflare-DDNS](./apps/cloudflare-ddns/compose.yml) - Dynamic DNS record updating to Cloudflare.
- [Deemix](./apps/deemix/compose.yml) - Deezer music downloader.
- [Gluetun](./apps/gluetun/compose.yml) - VPN.
- [Jellyfin](./apps/jellyfin/compose.yml) - Media server.
- [Lidarr](./apps/lidarr/compose.yml) - PVR for music.
- [qBittorrent](./apps/qbittorrent/compose.yml) - Torrenting client.
- [Radarr](./apps/radarr/compose.yml) - PVR for anime-movies/movies.
- [Sonarr](./apps/sonarr/compose.yml) - PVR for anime/tv.

networks:

## License

[Zlib][license]

[license]: LICENSE.md "Zlib"
