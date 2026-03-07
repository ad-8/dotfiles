#!/usr/bin/env sh

result=$(dunstctl is-paused)

if [ "$result" == "true" ]; then
    echo ""
else
    echo ""
fi
