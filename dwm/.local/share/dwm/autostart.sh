#!/usr/bin/env sh

# foo
#
# why nm doesnt work when started here
#nm-applet &
blueman-applet &

dunst &
.screenlayout/lg-ultrawide.sh &
licht hi &
#nm-applet &
dwmblocks &

# TODO check if it works on Mac Keyboard = ignores it
setxkbmap -option altwin:swap_lalt_lwin

sleep 2
xfce4-power-manager &
feh --bg-fill --randomize ~/Pictures/nord-background &
emacs --daemon &
sxhkd -t 3 &
#picom &
#$HOME/scripts/dwm-simple-status.sh &
syncthing -no-browser &

#sleep 1
#protonvpn-cli ks --off && protonvpn-cli ks --permanent && protonvpn-cli c --protocol tcp --fastest &

megasync &
