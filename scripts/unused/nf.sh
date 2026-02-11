#!/usr/bin/env sh

if [ -f /etc/debian_version ]; then
    clear && fastfetch && ncal -w && echo && LC_TIME=de_DE.UTF-8 date '+%a %d.%m.%Y %H:%M:%S' && echo
else
    clear && fastfetch && cal -w --monday && echo && LC_TIME=de_DE.UTF-8 date '+%H:%M:%S' && echo
fi
