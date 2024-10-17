#!/usr/bin/env bash

source ~/.config/yadm/packages.sh

# Packages used in pacstrap when installing Arch
PKG_PACSTRAP="\
base \
base-devel \
linux \
linux-firmware \
inetutils \
man-db \
man-pages \
networkmanager \
wpa_supplicant \
openssh \
vim \
git \
yadm \
"

INSTALLED_PACKAGES=$(pacman -Qq | sort)
EXPLICIT_PACKAGES=$(pacman -Qqe | sort)
ORPHANED_PACKAGES=$(pacman -Qqtd | sort)
DEFINED_PACKAGES=$(echo "$PACKAGES $PKG_PACSTRAP" | xargs -n1 | sort | uniq)
RETIRED_PACKAGES=$(echo "$PKG_RETIRED" | xargs -n1 | sort | uniq)

NOT_INSTALLED=$(comm -13 <(echo "$INSTALLED_PACKAGES") <(echo "$DEFINED_PACKAGES"))
NOT_IN_BOOTSTRAP=$(comm -23 <(echo "$EXPLICIT_PACKAGES") <(echo "$DEFINED_PACKAGES"))
RETIRED_STILL_INSTALLED=$(comm -12 <(echo "$INSTALLED_PACKAGES") <(echo "$RETIRED_PACKAGES"))

if [ "$NOT_INSTALLED" = '' ] && [ "$NOT_IN_BOOTSTRAP" = '' ] && [ "$RETIRED_STILL_INSTALLED" = '' ]; then
    echo "In sync"
    exit 0
fi

if [ "$NOT_INSTALLED" != '' ]; then
    echo "Packages defined in bootstrap but not installed:"
    echo "$NOT_INSTALLED"
    echo
fi

if [ "$NOT_IN_BOOTSTRAP" != '' ]; then
    echo "Packages explicitly installed but not defined in bootstrap:"
    echo "$NOT_IN_BOOTSTRAP"
    echo
fi

if [ "$RETIRED_STILL_INSTALLED" != '' ]; then
    echo "Packages defined as retired but still installed:"
    echo "$RETIRED_STILL_INSTALLED"
    echo
fi

if [ "$ORPHANED_PACKAGES" != '' ]; then
    echo "Orphaned packages (installed as dependency but not required by any installed packages - uninstall with: 'pacman -Qqdt | sudo pacman -Rs -'):"
    echo "$ORPHANED_PACKAGES"
    echo
fi

exit 1

