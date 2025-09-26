# Notes

These are some of my personal notes on Docker for future reference.

## DNS

By default, Docker uses your system DNS. I prefer to bypass this as I have some quirks setup with my NextDNS profile.
Additionally, the local-only reverse proxies I have setup won't be able to get certificates without bypassing it.
Instead of configuring it per-container, I prefer to bypass it all together and use [Quad9](https://quad9.net).

You can do this by updating `/etc/docker/daemon.json` to include `"dns": ["9.9.9.9", "149.112.112.112"]`.

## IPV6

Docker has had iffy IPV6 support for a while, but it's fine now.
However, I still disable it daemon-wide due to not having a real address yet. I really need to bug Google Fiber...

You can do this by updating `/etc/docker/daemon.json` to include `"ipv6": false`.

## Storage

By default, the Docker daemon stores all named volume data at `/var/lib/docker`.
This is fine for most use cases, but I prefer to store all Docker data on a specific drive.
Additionally, most people _say_ XFS is the best FS for Docker.

You can change this by updating `/etc/docker/daemon.json` to include `"data-root": "/path/to/data"`.
