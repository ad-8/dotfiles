#!/usr/bin/env sh

back=$(xbacklight -get)

printf " %.0f\n" "$back"
