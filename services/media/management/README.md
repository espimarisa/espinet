# Notes

## API Keys

After initial deployment, you will need to get API keys from 'ARR apps and add them to .env.
Each of these can be found by going to the appropriate web interface, and then navigating to Settings -> General.

## Prowlarr

To connect Prowlarr to apps, you will need to figure out their IP address on the Gluetun network. `docker network inspect gluetun`.
Once you have their IPV4 address, you can add each app by configuring the Prowlarr URL to be `gluetun:port` and the app url to be `172.17.XX.XX`.

## Flaresolverr

Flaresolverr's captcha solving mechanism is borked, but it's still useful. You'll need to configure it in Prowlarr.
You can do so by going to Settings -> Indexers and adding Flaresolverr. Make it use the tag `flaresolverr` and point to `127.0.0.1:port` as the server.
