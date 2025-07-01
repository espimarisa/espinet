# Notes

After initial setup, be sure to enable the application-level killswitch.

1. Access the qBittorrent WebUI.
2. Navigate to Tools > Options > Preferences > Advanced > Network Interface
3. Select `tun0` as the only interface.

Verify the container's IP: `docker exec -it qbittorrent curl ifconfig.io`
