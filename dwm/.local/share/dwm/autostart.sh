#!/usr/bin/env sh

# why nm doesnt work when started here
#nm-applet &
blueman-applet &

dunst &
.screenlayout/lg-ultrawide.sh &
licht hi &
dwmblocks &

# Disable annoying beep from computer (I think on keypresses when an action is not available)
xset b off

# TODO enable only if *not* on macbook
setxkbmap -option altwin:swap_lalt_lwin

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

sleep 2
xfce4-power-manager &
feh --bg-scale --randomize ~/Sync/wallpapers/wallpapers-ax-fav &
emacs --daemon &
sxhkd -t 3 &
#picom &
#$HOME/scripts/dwm-simple-status.sh &
syncthing -no-browser &
megasync &

#sleep 1
#protonvpn-cli ks --off && protonvpn-cli ks --permanent && protonvpn-cli c --protocol tcp --fastest &

