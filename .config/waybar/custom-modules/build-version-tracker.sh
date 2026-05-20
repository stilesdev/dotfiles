#!/usr/bin/env bash

FILE="$HOME/.config/waybar/custom-modules/build-version-tracker.txt"
DEFAULT_VALUE="R0 0.0.0"

if [ ! -e "$FILE" ]; then
    echo -n "$DEFAULT_VALUE" > "$FILE"
fi

VERSION=$(cat $FILE)

if [[ "$1" = "copy" ]]; then
    echo -n "$VERSION" | wl-copy
    exit 0
fi

increment() {
    local amount=$1

    local release=$(cat "$FILE" | cut -d ' ' -f1)
    local major=$(cat "$FILE" | cut -d ' ' -f2 | cut -d. -f1)
    local minor=$(cat "$FILE" | cut -d ' ' -f2 | cut -d. -f2)
    local patch=$(cat "$FILE" | cut -d ' ' -f2 | cut -d. -f3)

    patch=$(($patch + $amount))

    VERSION="$release $major.$minor.$patch"

    echo -n "$VERSION" > "$FILE"
}

is_enabled() {
    if [[ "$VERSION" = "$DEFAULT_VALUE" ]]; then
        return 1
    else
        return 0
    fi
}

if [[ "$1" = "inc" ]]; then
    increment 1
    echo "$VERSION"
    pkill -SIGRTMIN+1 waybar
elif [[ "$1" = "dec" ]]; then
    increment -1
    echo "$VERSION"
    pkill -SIGRTMIN+1 waybar
elif is_enabled; then
    echo "$VERSION"
fi
