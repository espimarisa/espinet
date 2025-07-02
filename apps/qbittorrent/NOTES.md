# Notes

## Vuetorrent

Located at `/vuetorrent` thanks to DOCKER_MODS.

## Authentication

Be sure to disable local authentication. The WebUI spits out a temporary password every bootup, so we need to change it.

1. Access the qBittorrent WebUI.
2. Navigate to Tools > Options > WebUI
3. Enable Bypass authentication for clients on localhost/whitelisted IP subnets.
   - `172.20.0.0/16,192.168.1.0/24`

## Killswitch

After initial setup, be sure to enable the application-level killswitch.

1. Access the qBittorrent WebUI.
2. Navigate to Tools > Options > Preferences > Advanced > Network Interface
3. Select `tun0` as the only interface.

Verify the container's IP: `docker exec -it qbittorrent curl ifconfig.io`
