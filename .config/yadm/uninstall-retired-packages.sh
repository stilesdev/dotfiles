#!/usr/bin/env bash

source ~/.config/yadm/packages.sh || exit $?

echo "Removing retired packages"
# this must be done one at a time, as pacman will fail if any of the listed packages are already uninstalled
for pkg in $(echo $PKG_RETIRED); do sudo pacman --noconfirm -Rs $pkg; done

