#!/usr/bin/env sh

playerctl pause

if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    swaylock --color 000000 --show-failed-attempts
else
    i3lock --color 000000 --show-failed-attempts
fi
