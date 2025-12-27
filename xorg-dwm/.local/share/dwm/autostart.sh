#!/usr/bin/env sh

dunst &
dwmblocks &

# Disable annoying beep from computer (I think on keypresses when an action is not available)
xset b off
#xset s off
#xset -dpms

xset s 5400 0
xset dpms 0 0 5400

# TODO test keyboard repeat rate
xset r rate 200 35 &

xautolock -time 30 -locker slock &

# setxkbmap de -option altwin:swap_lalt_lwin -option caps:escape
setxkbmap de -option caps:escape

# TODO keyring / polkit
#/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

sleep 2
~/foo.sh &
firefox &
emacs --daemon &
sxhkd -t 3 &
#picom &
syncthing serve --no-browser &

sleep 1
backlight 80 &
feh --bg-scale ~/Downloads/freebsd-blue-wallpaper.jpg &

