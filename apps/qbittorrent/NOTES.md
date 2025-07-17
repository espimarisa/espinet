# Notes on qBittorrent

After a fresh deployment, you need to:

1. Grab your temporary password from initial startup through `docker compose logs qbittorrent`.
2. Login to the web interface at port 8080.
3. Navigate to Options > WebUI.
    - Enable using an alternative web interface.
        - Set the path to /vuetorrent
    - Enable bypass authentication for localhost connections
    - Enable bypass authentication for allowed subnets.
        - Set the list of subnets to match your FIREWALL_OUTBOUND_SUBNETS.
