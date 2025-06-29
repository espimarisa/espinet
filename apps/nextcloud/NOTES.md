# Notes on Nextcloud

Nextcloud is a problem child. Most things are automated, but here's a few things to do after deployment that can't be:

## Post-install

```sh
# This sets the Nextcloud maintenence window to a non-peak hour (5AM).
docker exec -it nextcloud sh -c "php occ config:system:set maintenance_window_start --value=5"

# This allows for proper Mimetype migrations.
docker exec -it nextcloud sh -c "php occ maintenance:repair --include-expensive"
```

## Cloudflare

If you're proxying your Nextcloud through Cloudflare instead of exposing your origin IP, you will need to set `maxChunkSize` in each of your desktop clients to be below 100MB if you are on the free plan. Otherwise, large uploads will fail at times.

## DKIM

I personally use Fastmail for all of my email services. DKIM will fail if you don't have an explicit alias as Fastmail has a pretty strict policy unlike _some_ services (cough mailbox).
