#!/bin/sh

if [ -z "$1" ]; then
    mute=$(pacmd list-sources | grep "\* index:" -A 11 | grep "muted")
else
    mute=$(pacmd list-sources | grep "$1" -A 11 | grep "muted")
fi

# echo $mute

if [ -z "$mute" ]; then
    echo "%{F#393f4c}%{F-}"
else
    if [ -z "${mute##*yes}" ]; then
        echo "%{F#cc575d}%{F-}"
    else
        echo "%{F#55aa55}%{F-}"
    fi
fi
