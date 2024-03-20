#!/usr/bin/env sh

#!/bin/bash

# Check if the system is Debian
if [ -f /etc/debian_version ]; then
    clear && neofetch && ncal -w && echo && LC_TIME=de_DE.UTF-8 date '+%a %d.%m.%Y %H:%M:%S' && echo
else
    clear && neofetch && cal -w --monday && echo && LC_TIME=de_DE.UTF-8 date '+%a %d.%m.%Y %H:%M:%S' && echo
fi
