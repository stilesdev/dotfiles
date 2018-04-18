#!/usr/bin/env bash

icon="$HOME/Scripts/lock-icon.png"
tempbg="/tmp/screen.png"

scrot "$tempbg"
convert "$tempbg" -scale 10% -scale 1000% "$tempbg"
convert "$tempbg" "$icon" -gravity center -composite -matte "$tempbg"
i3lock -i "$tempbg"

rm "$tempbg"
