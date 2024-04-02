#!/usr/bin/env bash 

#COLORSCHEME=DoomOne


### AUTOSTART PROGRAMS ###
#lxsession &
"$HOME"/.screenlayout/arandr-config-viewsonic.sh &
sleep 1
set_random_wallpaper
sleep 1
picom --daemon &
/usr/bin/emacs --daemon &
sxhkd &

nm-applet &
blueman-applet &
megasync &
xfce4-power-manager &
#"$HOME"/.screenlayout/layout.sh &
#sleep 1
#conky -c "$HOME"/.config/conky/qtile/01/"$COLORSCHEME".conf || echo "Couldn't start conky."

### UNCOMMENT ONLY ONE OF THE FOLLOWING THREE OPTIONS! ###
# 1. Uncomment to restore last saved wallpaper
#xargs xwallpaper --stretch < ~/.cache/wall &
# 2. Uncomment to set a random wallpaper on login
# find /usr/share/backgrounds/dtos-backgrounds/ -type f | shuf -n 1 | xargs xwallpaper --stretch &
# 3. Uncomment to set wallpaper with nitrogen
# nitrogen --restore &
