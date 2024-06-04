#!/usr/bin/env bash

# Packages used in the past but no longer needed
PKG_RETIRED="\
arc-gtk-theme \
arc-icon-theme \
code \
faba-icon-theme-git \
gtk-engine-murrine \
hplip \
insomnia \
insomnia-bin \
konsole \
kwalletmanager \
libreoffice-still \
libu2f-host \
moka-icon-theme-git \
powerline-go \
rofi \
scrot \
subversion \
superproductivity-bin \
synergy \
tk-engine-murrine \
yubioath-desktop \
"

echo "Removing retired packages"
# this must be done one at a time, as pacman will fail if any of the listed packages are already uninstalled
for pkg in $(echo $PKG_RETIRED); do sudo pacman --noconfirm -Rs $pkg; done

