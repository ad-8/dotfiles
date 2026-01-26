#!/usr/bin/env sh

# why nm doesnt work when started here
nm-applet &
blueman-applet &

dunst &
#.screenlayout/view.sh &
~/scripts/bb/licht.clj hi &
dwmblocks &

# Disable annoying beep from computer (I think on keypresses when an action is not available)
xset b off
#xset s off
#xset -dpms

xset s 5400 0
xset dpms 0 0 5400
xautolock -time 10 -locker slock &

# TODO disable on macbook
# setxkbmap -option altwin:swap_lalt_lwin -option caps:escape
setxkbmap -option caps:escape

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

sleep 1
firefox &
sleep 1
xfce4-power-manager &
feh --bg-scale --randomize ~/sync/wallpapers/wallpapers-ax-fav &
emacs --daemon &
sxhkd -t 3 &
syncthing -no-browser &
megasync &

