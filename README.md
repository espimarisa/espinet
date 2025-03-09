#	espinet

compose	setup	for	my	homelab,	mostly	focused	on	multimedia	and	archival

##	setup

wip

-	create	your	environment	variable	file	in	`.env`	and	follow	the	documentation	inside	of	`compose.yml`
-	run	`bash	./scripts/setup.sh`
-	todo:	guide	on	how	to	setup	the	other	services

##	services

-	nextcloud:	file	syncing/backups
-	gluetun:	vpn	for	torrenting
-	qbittorrent:	bittorrent	client
-	qbittorrent-natmap:	auto	port	forwarding
-	jellyfin:	media	server	for	anime/tv/movies
-	navidrome:	media	server	for	music
-	cloudflared:	cloudflare	tunneling	support
-	deemix:	music	downloader	via	grabbing	from	deemix
-	lidarr:	music	pvr	used	in	combination	with	deemix
-	radarr:	movies	pvr
-	sonarr:	tv/anime	pvr
-	prowlarr:	pvr	manager
-	flaresolverr:	cloudflare	bypasser

##	license

[zlib/libpng](LICENSE.md)
