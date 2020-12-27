#!/bin/sh

if [ -z "$1" ]; then
    mute=$(pacmd list-sources | grep "\* index:" -A 11 | grep "muted")
else
    mute=$(pacmd list-sources | grep "$1" -A 11 | grep "muted" )
fi

if [ -z "$mute" ]; then
    echo "%{F#444}%{F-}"
else
    if [ "$mute" == *"yes"* ]; then
        echo "%{F#f00}%{F-}"
    else
        echo "%{F#0f0}%{F-}"
    fi
fi
