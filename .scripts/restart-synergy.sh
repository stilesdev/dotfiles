#!/usr/bin/env bash

pkill synergy
while pgrep synergy > /dev/null 2>&1; do sleep 0.1; done

case $(hostname) in
arcade* | bismuth*)
    if [ "$AUTORANDR_CURRENT_PROFILE" == "laptop-default" ]; then
        HOST="10.0.1.5"
    else
        HOST="arena.stiles.me"
    fi

    if [ $(whoami) == 'matthew' ]; then
        /usr/bin/synergyc --enable-crypto "$HOST"
    else
        su -c "/usr/bin/synergyc --enable-crypto $HOST" - matthew
    fi
    ;;
esac
