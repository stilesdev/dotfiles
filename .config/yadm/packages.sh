#!/usr/bin/env bash

GRAPHICS_VENDOR=''
IS_LAPTOP=false
IS_DOCKER_HOST=false

case $(hostname) in
arcade*)
    GRAPHICS_VENDOR='intel'
    IS_LAPTOP=true
    IS_DOCKER_HOST=true
    ;;
arena*)
    GRAPHICS_VENDOR='nvidia'
    IS_DOCKER_HOST=true
    ;;
builder*)
    GRAPHICS_VENDOR='none'
    ;;
encom*)
    GRAPHICS_VENDOR='none'
    IS_DOCKER_HOST=true
    ;;
jstiles-archlinux*)
    GRAPHICS_VENDOR='amd'
    IS_DOCKER_HOST=true
    ;;
pkg*)
    GRAPHICS_VENDOR='none'
    IS_DOCKER_HOST=true
    ;;
purgos*)
    GRAPHICS_VENDOR='none'
    ;;
esac

if [ "$GRAPHICS_VENDOR" = 'intel' ]; then
    PKG_GRAPHICS=(
        lib32-mesa
        mesa
        xf86-video-intel
    )
elif [ "$GRAPHICS_VENDOR" = 'nvidia' ]; then
    PKG_GRAPHICS=(
        lib32-nvidia-utils
        nvidia
        nvidia-settings
        nvidia-utils
    )
elif [ "$GRAPHICS_VENDOR" = 'amd' ]; then
    PKG_GRAPHICS=(
        lib32-mesa
        mesa
        vulkan-radeon
        xf86-video-amdgpu
    )
elif [ "$GRAPHICS_VENDOR" = 'none' ]; then
    PKG_GRAPHICS=()
else
    echo "No graphics vendor defined for host, exiting!" 2>&1
    exit 1
fi

# Installed on all systems
PKG_SYSTEM=(
    cronie
    dosfstools
    nohang
    ntfs-3g
    pacman-contrib
    reflector
    smbclient
    sshfs
    systemd-boot-pacman-hook
    usbutils
)
PKG_UTILS=(
    autossh
    bat
    git
    git-filter-repo
    gnupg
    htop
    imagemagick
    jq
    ldns # provides drill command
    nmap
    openssh
    rsync
    tailscale
    tig
    unzip
    wget
    zip
)
PKG_DOCKER=(
    docker
    docker-buildx
    docker-compose
)
PKG_CLI=(
    dbmate
    fnm-bin
    fzf
    go
    jq
    neofetch
    neovim
    postgresql-libs
    ripgrep
    sqlc
    starship
    tig
    tmux
    vim
    wezterm
    zsh
    zsh-autosuggestions
    zsh-history-substring-search
    zsh-syntax-highlighting
)

# GUI Packages
PKG_GUI_XORG=(
    xorg-server
    xorg-xev
    xorg-xkill
    xorg-xmodmap
    xorg-xrdb
)
PKG_GUI_THEME=(
    catppuccin-gtk-theme-mocha
    gnome-themes-extra
    papirus-icon-theme
    qt5-styleplugins
    xcursor-neutral
)
PKG_GUI_DE=(
    betterlockscreen
    cups
    cups-pdf
    dunst
    i3-wm
    lightdm
    lightdm-slick-greeter
    network-manager-applet
    picom
    polybar
    udiskie
    ulauncher
)
PKG_GUI_FILEBROWSER=(
    7zip
    ark
    ffmpegthumbnailer
    gvfs-mtp
    gvfs-smb
    thunar
    tumbler
    unarchiver
)
PKG_GUI_UTILS=(
    arandr
    autorandr
    eog
    flameshot
    kcalc
    mediainfo-gui
    numlockx
    seahorse
    xclip
    yubico-authenticator-bin
    zsa-udev
)
PKG_GUI_APPS=(
    brave-bin
    filelight
    firefox
    obsidian
    onlyoffice-bin
    spotify
    synology-drive
    vlc
    zen-browser-bin
)
PKG_AUDIO=(
    alsa-utils # includes alsamixer utility
    pavucontrol # volume control GUI
    pipewire # audio/video router/processor
    pipewire-alsa # pipewire alsa configuration
    pipewire-audio # pipewire audio support (including bluetooth audio support)
    pipewire-pulse # pipewire as pulseaudio replacement
    playerctl
    python-dbus # used by ~/.scripts/polybar-modules/spotify-status.py
    wireplumber # pipewire session/policy manager
)
PKG_FONTS=(
    stilesdev-fonts
)
PKG_YUBIKEY=(
    ccid
    gcr
    libfido2
    libusb-compat
    pcsclite
    pinentry
)
PKG_BLUETOOTH=(
    blueman
)

PKG_LAPTOP=(
    thermald
    tlp
    xf86-input-libinput
    xorg-xbacklight
)

PKG_GAMES=(
    clonehero
    gamescope
    linux-headers # needed for dkms
    rmg
    steam
    xdg-desktop-portal-gtk # needed for file picker in steam
    xone-dkms-git # kernel module for Xbox One controllers
    xone-dongle-firmware # firmware for Xbox One controller dongle
    xpad-noone-git # xone disables the xpad kernel module, this is xpad without xone controller support, to restore usage of other gamepads (like 8bitdo ultimate 2)
)

PKG_GAMEDEV=(
    aseprite
    godot
    love
)

PKG_ARENA_ONLY=(
    betaflight-configurator-bin
    calibre
    cura-bin
    expresslrs-configurator-bin
    flatpak # for plex desktop app
    oscar-bin
    spek # spectrum analyzer for checking actual bitrate of flac files
)

PKG_NON_WORK=(
    proton-vpn-gtk-app
)

PKG_WORK=(
    azure-cli
    cisco-secure-client
    composer
    evolution
    evolution-ews
    freerdp
    git-lfs
    google-chrome
    jetbrains-toolbox
    kcachegrind
    kubectl
    libvncserver
    minikube
    navi
    nmap
    php
    postgresql-libs
    postman-bin
    remmina
    storageexplorer
    synology-drive
    teams-for-linux
    timeshift
    visual-studio-code-bin
    xedgewarp-git
)

PKG_LIBVIRT=(
    dmidecode
    dnsmasq
    iptables-nft
    libvirt
    qemu-desktop
    samba
    swtpm # required for emulated TPM 2.0
    virt-manager
)

# Packages used in the past but no longer needed
PKG_RETIRED=(
    arc-gtk-theme
    arc-icon-theme
    code
    faba-icon-theme-git
    gtk-engine-murrine
    hplip
    insomnia
    insomnia-bin
    konsole
    kwalletmanager
    libreoffice-still
    libu2f-host
    moka-icon-theme-git
    powerline-go
    rofi
    scrot
    subversion
    superproductivity-bin
    synergy
    tk-engine-murrine
    vcsh
    yubioath-desktop
)

# Installed on all systems
PACKAGES=("${PKG_SYSTEM[@]}" "${PKG_UTILS[@]}" "${PKG_CLI[@]}")

if ($IS_DOCKER_HOST); then
    PACKAGES=("${PACKAGES[@]}" "${PKG_DOCKER[@]}")
fi

if [ "$GRAPHICS_VENDOR" != 'none' ]; then
    # Installed only on GUI systems
    PACKAGES=("${PACKAGES[@]}" "${PKG_GRAPHICS[@]}" "${PKG_GUI_XORG[@]}" "${PKG_GUI_THEME[@]}" "${PKG_GUI_DE[@]}" "${PKG_GUI_FILEBROWSER[@]}" "${PKG_GUI_UTILS[@]}" "${PKG_GUI_APPS[@]}" "${PKG_AUDIO[@]}" "${PKG_FONTS[@]}" "${PKG_YUBIKEY[@]}" "${PKG_BLUETOOTH[@]}")

    if ($IS_LAPTOP); then
        PACKAGES=("${PACKAGES[@]}" "${PKG_LAPTOP[@]}")
    fi

    if [ "$USER" = 'jstiles' ]; then
        PACKAGES=("${PACKAGES[@]}" "${PKG_WORK[@]}" "${PKG_LIBVIRT[@]}")
    else
        PACKAGES=("${PACKAGES[@]}" "${PKG_NON_WORK[@]}")
    fi

    if [ "$(hostname)" = 'arena' ]; then
        PACKAGES=("${PACKAGES[@]}" "${PKG_GAMES[@]}" "${PKG_GAMEDEV[@]}" "${PKG_ARENA_ONLY[@]}")
    fi

fi

PACKAGES="${PACKAGES[@]}"
PKG_RETIRED="${PKG_RETIRED[@]}"

export PACKAGES
export PKG_RETIRED
export GRAPHICS_VENDOR
export IS_LAPTOP
export IS_DOCKER_HOST

