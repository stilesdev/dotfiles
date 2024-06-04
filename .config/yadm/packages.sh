#!/usr/bin/env bash

GRAPHICS_VENDOR=''
IS_LAPTOP=false

case $(hostname) in
arcade*)
    GRAPHICS_VENDOR='intel'
    IS_LAPTOP=true
    ;;
arena*)
    GRAPHICS_VENDOR='nvidia'
    ;;
encom*)
    GRAPHICS_VENDOR='none'
    ;;
jstiles-archlinux*)
    GRAPHICS_VENDOR='amd'
    ;;
pkg*)
    GRAPHICS_VENDOR='none'
    ;;
esac

# Video drivers by vendor
PKG_GRAPHICS_NVIDIA="\
lib32-nvidia-utils \
nvidia \
nvidia-utils \
"
PKG_GRAPHICS_AMD="\
lib32-mesa \
mesa \
vulkan-radeon \
xf86-video-amdgpu \
"
PKG_GRAPHICS_INTEL="\
lib32-mesa \
mesa \
xf86-video-intel \
"

if [ "$GRAPHICS_VENDOR" = 'intel' ]; then
    PKG_GRAPHICS="$PKG_GRAPHICS_INTEL"
elif [ "$GRAPHICS_VENDOR" = 'nvidia' ]; then
    PKG_GRAPHICS="$PKG_GRAPHICS_NVIDIA"
elif [ "$GRAPHICS_VENDOR" = 'amd' ]; then
    PKG_GRAPHICS="$PKG_GRAPHICS_AMD"
elif [ "$GRAPHICS_VENDOR" = 'none' ]; then
    PKG_GRAPHICS=""
else
    echo "No graphics vendor defined for host, exiting!" 2>&1
    exit 1
fi

# Installed on all systems
PKG_SYSTEM="\
cronie \
nohang \
pacman-contrib \
smbclient \
systemd-boot-pacman-hook \
usbutils \
"
PKG_UTILS="\
autossh \
bat \
git \
gnupg \
htop \
imagemagick \
jq \
openssh \
rsync \
tig \
unzip \
wget \
zip \
"
PKG_DOCKER="\
docker \
docker-buildx \
docker-compose \
"
PKG_CLI="\
fnm-bin \
fzf \
go \
jq \
neofetch \
neovim \
ripgrep \
starship \
tig \
tmux \
vim \
wezterm \
zsh \
zsh-autosuggestions \
zsh-history-substring-search \
zsh-syntax-highlighting \
"

# GUI Packages
PKG_GUI_XORG="\
xorg-server \
xorg-xev \
xorg-xmodmap \
xorg-xrdb \
"
PKG_GUI_THEME="\
catppuccin-gtk-theme-mocha \
gnome-themes-extra \
papirus-icon-theme \
qt5-styleplugins \
xcursor-neutral \
"
PKG_GUI_DE="\
betterlockscreen \
dunst \
i3-wm \
lightdm \
lightdm-slick-greeter \
picom \
polybar \
udiskie \
ulauncher \
"
PKG_GUI_FILEBROWSER="\
ark \
ffmpegthumbnailer \
p7zip \
thunar \
tumbler \
unarchiver \
"
PKG_GUI_UTILS="\
arandr \
autorandr \
eog \
flameshot \
kcalc \
numlockx \
seahorse \
xclip \
yubico-authenticator-bin \
zsa-udev \
"
PKG_GUI_APPS="\
firefox \
google-chrome \
onlyoffice-bin \
spotify \
visual-studio-code-bin \
vlc \
"
PKG_AUDIO="\
alsa-utils \
pavucontrol \
playerctl \
pulseaudio \
pulseaudio-equalizer-ladspa \
python-dbus \
"
PKG_FONTS="\
stilesdev-fonts \
"
PKG_YUBIKEY="\
ccid \
gcr \
libfido2 \
libusb-compat \
pcsclite \
pinentry \
"
PKG_BLUETOOTH="\
blueman \
"

PKG_LAPTOP="\
thermald \
tlp \
xf86-input-libinput \
xorg-xbacklight \
"

# Installed on all systems
PACKAGES="$PKG_SYSTEM $PKG_UTILS $PKG_DOCKER $PKG_CLI"

if [ "$GRAPHICS_VENDOR" != 'none' ]; then
    # Installed only on GUI systems
    PACKAGES="$PACKAGES $PKG_GRAPHICS $PKG_GUI_XORG $PKG_GUI_THEME $PKG_GUI_DE $PKG_GUI_FILEBROWSER $PKG_GUI_UTILS $PKG_GUI_APPS $PKG_AUDIO $PKG_FONTS $PKG_YUBIKEY $PKG_BLUETOOTH"

    if ($IS_LAPTOP); then
        PACKAGES="$PACKAGES $PKG_LAPTOP"
    fi
fi

export PACKAGES
export GRAPHICS_VENDOR
export IS_LAPTOP

