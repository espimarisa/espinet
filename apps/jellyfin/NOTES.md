# Notes on Jellyfin

Jellyfin is lovely and has come a long way. I've not ran into too many problems with it, but I do have modern hardware.

## Metadata

I personally use TVDB for Anime and TV and TMDB for Movies. I've not ran into too many problems, but my media library strictly follows Jellyfin's expected standards and has been made to do so with various 'ARR apps over the years.

There exist much more powerful solutions for metadata and automation, but I don't really want to automate downloading as I'm quite picky on what release to use, and my media library is pretty much complete at this point.

## Hardware Acceleration

VAAPI seems to work fine out of the box with passing /dev/dri/renderD128 through and configuring Jellyfin to work with it. I am using my spare Radeon 6600 for this task, and it seems to hold up fine, and does much better than the onboard UHD 770 or my old 1060 3GB. Yay for AV1 decode support!

## Tone Mapping/HDR

Untested, previously was a pain to setup. Will update with more information in the future.
