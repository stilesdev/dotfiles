#!/usr/bin/env bash

pkill picom
while pgrep picom > /dev/null 2>&1; do sleep 0.1; done
picom -b