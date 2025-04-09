#!/usr/bin/env bash

FILE="$HOME/.scripts/polybar-modules/build-version-tracker.txt"

if [ ! -e "$FILE" ]; then
    echo -n "0.0.0" > "$FILE"
fi

VERSION=$(cat $FILE)
SLEEP_PID=0

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

    if [ "$SLEEP_PID" -ne 0 ]; then
        kill $SLEEP_PID >/dev/null 2>&1
        SLEEP_PID=0
    fi
}

trap "increment 1" USR1
trap "increment -1" USR2

while true; do
    echo "$VERSION"
    sleep infinity &
    SLEEP_PID=$!
    wait
done
