#!/usr/bin/env sh

# This little script is a simple alternative to dwmblocks or other status bars.
# Start it via the dwm `autostart.sh` script.
while true; do
	xsetroot -name "$(LC_TIME=de_DE.UTF-8 date '+%a %d.%m.%Y %H:%M:%S')"
	sleep 1
done

