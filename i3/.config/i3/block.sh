#!/bin/bash

orig=/tmp/screen_locked0.png
pixl=/tmp/screen_locked1.png

scrot $orig

# pixelated 
convert $orig -scale 10% -scale 1000% $pixl

# clearer blur, takes longer
# convert $orig -blur 0x6 $pixl

rm $orig

# xss-lock --transfer-sleep-lock -- i3lock --nofork
# xss-lock --transfer-sleep-lock -- i3lock --nofork -i $pixl
i3lock -i $pixl
