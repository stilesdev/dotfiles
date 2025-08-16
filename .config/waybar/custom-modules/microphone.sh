#!/bin/sh

ACTION="$1"
SOURCE_NAME="$2"

if [ -z "$2" ]; then
    SOURCE_NAME=$(pactl get-default-source)
fi

toggle_mute() {
    local source_name="$1"
    pactl set-source-mute "$source_name" toggle 2>/dev/null
}

print_status() {
    local source_name="$1"
    local muted=$(pactl get-source-mute "$source_name" 2>/dev/null)

    if [ -z "$muted" ]; then
        echo '{"tooltip":"not found: '"$source_name"'","alt":"disabled","class":"disabled"}'
    else
        if [ -z "${muted##*yes}" ]; then
            echo '{"tooltip":"muted: '"$source_name"'","alt":"muted","class":"muted"}'
        else
            echo '{"tooltip":"unmuted: '"$source_name"'","alt":"unmuted","class":"unmuted"}'
        fi
    fi
}

watch_status() {
    local source_name="$1"
    local source_id=$(pactl list short sources | grep "$source_name" | cut -f1)

    pactl subscribe 2>/dev/null | grep --line-buffered "source #$source_id" | while read line; do print_status "$source_name"; done
}

case "$ACTION" in
    toggle)
        toggle_mute "$SOURCE_NAME"
        ;;
    status)
        print_status "$SOURCE_NAME"
        ;;
    watch)
        print_status "$SOURCE_NAME"
        watch_status "$SOURCE_NAME"
        ;;
esac
