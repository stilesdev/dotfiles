#!/bin/sh

if [ -z "$1" ]; then
    mute=$(pacmd list-sources | grep "\* index:" -A 11 | grep "muted")
else
    mute=$(pacmd list-sources | grep "$1" -A 11 | grep "muted")
fi

# echo $mute

if [ -z "$mute" ]; then
    echo "%{F#585b70}%{F-}" # catppuccin mocha surface2
else
    if [ -z "${mute##*yes}" ]; then
        echo "%{F#f38ba8}%{F-}" # catppuccin mocha red
    else
        echo "%{F#a6e3a1}%{F-}" # catppuccin mocha green
    fi
fi
