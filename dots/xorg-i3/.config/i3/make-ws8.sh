#!/bin/sh

i3-msg 'workspace 8 ♫; append_layout ~/.config/i3/ws8b.json' &
kitty --title 'musikcube' --name kitty1 --hold musikcube &
kitty --title 'metal logo' --name kitty2 --hold metal logo &
kitty --title 'metal info' --name kittyX --hold metal info &
kitty --title 'metal art' --name kitty3 --hold metal art &
kitty --title 'metal lyrics' --name kitty4 --hold metal lyrics &
echo "done"

