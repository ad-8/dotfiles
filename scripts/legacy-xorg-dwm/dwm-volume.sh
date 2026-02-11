#!/usr/bin/env sh

volume_info=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)

# Check if the response contains the word "MUTED"
if [[ $volume_info == *"MUTED"* ]]; then
    echo " "
else
    vol=$(echo "$volume_info" | tr -dc '0-9' | sed 's/^0\{1,2\}//')
    echo "󰕾 $vol"
fi
