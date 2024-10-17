#!/usr/bin/env bash

PROCESS="$1"

pkill "$PROCESS"
sleep 1
while pgrep "$PROCESS" >/dev/null 2>&1; do sleep 0.1; done
"$PROCESS"
