#!/usr/bin/env bash

pkill picom
sleep 1
while pgrep picom >/dev/null 2>&1; do sleep 0.1; done
picom -b
