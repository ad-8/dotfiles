#!/usr/bin/env sh

# foo
#
# why nm doesnt work when started here
#nm-applet &
blueman-applet &

dunst &
.screenlayout/arandr-config-viewsonic.sh &
sleep 2
xfce4-power-manager &
feh --bg-fill --randomize ~/Pictures/wallpapers &
emacs --daemon &
sxhkd -t 3 &
#picom &
$HOME/scripts/dwm-simple-status.sh &
syncthing -no-browser &

#nm-applet &
#sleep 1
#protonvpn-cli ks --off && protonvpn-cli ks --permanent && protonvpn-cli c --protocol tcp --fastest &

#megasync &
