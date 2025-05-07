#!/usr/bin/env bash

FILE="$HOME/.config/waybar/custom-modules/build-version-tracker.txt"

if [ ! -e "$FILE" ]; then
    echo -n "0.0.0" > "$FILE"
fi

VERSION=$(cat $FILE)

if [[ "$1" = "copy" ]]; then
    echo -n "$VERSION" | wl-copy
    exit 0
fi

increment() {
    local amount=$1

    local major=$(cat "$FILE" | cut -d. -f1)
    local minor=$(cat "$FILE" | cut -d. -f2)
    local patch=$(cat "$FILE" | cut -d. -f3)

    patch=$(($patch + $amount))

    VERSION="$major.$minor.$patch"

    echo -n "$VERSION" > "$FILE"
}

if [[ "$1" = "inc" ]]; then
    increment 1
    echo "$VERSION"
    kill -SIGRTMIN+1 waybar
elif [[ "$1" = "dec" ]]; then
    increment -1
    echo "$VERSION"
    kill -SIGRTMIN+1 waybar
else
    echo "$VERSION"
fi
