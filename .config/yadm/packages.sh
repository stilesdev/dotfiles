#!/usr/bin/env bash

GRAPHICS_VENDOR=''
IS_LAPTOP=false
IS_DOCKER_HOST=false

case $(hostname) in
arcade*)
    GRAPHICS_VENDOR='nvidia'
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
        lib32-mesa # 32-bit DRI driver for 3D acceleration
        lib32-vulkan-intel # 32-bit Vulkan support
        mesa # DRI driver for 3D acceleration
        vulkan-intel # Vulkan support
    )
elif [ "$GRAPHICS_VENDOR" = 'nvidia' ]; then
    PKG_GRAPHICS=(
        egl-wayland # NVIDIA Wayland implementation of EGL, required by hyprland
        lib32-nvidia-utils # 32-bit userspace drivers, for apps like Steam and Wine
        nvidia # official closed-source driver from NVIDIA
        nvidia-utils # userspace drivers, including Vulkan support
    )
elif [ "$GRAPHICS_VENDOR" = 'amd' ]; then
    PKG_GRAPHICS=(
        lib32-mesa # 32-bit DRI driver for 3D acceleration
        lib32-vulkan-radeon # 32-bit Vulkan support
        mesa # DRI driver for 3D acceleration
        vulkan-radeon # Vulkan support
    )
elif [ "$GRAPHICS_VENDOR" = 'none' ]; then
    PKG_GRAPHICS=()
else
    echo "No graphics vendor defined for host, exiting!" 2>&1
    exit 1
fi

# Installed on all systems
PKG_SYSTEM=(
    cronie # cron
    dosfstools # mkfs.fat
    lvm2 # LVM utilities
    nohang # low memory handler
    ntfs-3g # NTFS support
    pacman-contrib # paccache, pacdiff
    smbclient # SAMBA support
    systemd-boot-pacman-hook # pacman hook to upgrade systemd-boot after systemd upgrades
    usbutils # lsusb
)
PKG_UTILS=(
    autossh
    bat
    git
    gnupg
    htop
    imagemagick
    jq
    openssh
    reflector
    rsync
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
    fnm-bin
    fzf
    go
    jq
    kitty
    neofetch
    neovim
    ripgrep
    starship
    tig
    tmux
    vim
    wezterm-git
    zsh
    zsh-autosuggestions
    zsh-history-substring-search
    zsh-syntax-highlighting
)

# GUI Packages
# PKG_GUI_THEME=(
#     catppuccin-gtk-theme-mocha
#     gnome-themes-extra
#     papirus-icon-theme
#     qt5-styleplugins
#     xcursor-neutral
# )
PKG_GUI_DE=(
    hypridle # idle management daemon
    hyprland # main Wayland compositor
    hyprlock # screen lock
    hyprpaper # wallpaper utility
    hyprpicker # color picker, also used by hyprshot to freeze screen during screenshot
    hyprpolkitagent # polkit auth daemon (for GUI apps to request elevation)
    hyprshot # screenshot-taking utility
    network-manager-applet # tray applet for networkmanager
    swappy # screenshot annotation utility
    swaync # notification daemon
    udiskie # tray applet for managing removable disks
    ulauncher # application launcher
    uwsm # Wayland session manager (used to start hyprland)
    waybar # status bar
    wev # Wayland window debugging tool (similar to xev in X11)
    xdg-desktop-portal-gtk # fallback xdg-desktop-portal (file picker)
    xdg-desktop-portal-hyprland # main xdg-desktop-portal (screensharing, global shortcuts, etc)
)
PKG_GUI_FILEBROWSER=(
    # 7zip
    # ark
    # ffmpegthumbnailer
    gvfs-mtp
    gvfs-smb
    thunar
    # tumbler
    # unarchiver
)
PKG_GUI_UTILS=(
    # arandr
    # autorandr
    clipse
    eog
    # flameshot
    # kcalc
    # numlockx
    seahorse
    wl-clipboard # terminal clipboard utilities (wl-copy and wl-paste)
    yubico-authenticator-bin
)
PKG_GUI_APPS=(
    brave-bin
    firefox
    obsidian
    onlyoffice-bin
    spotify
    vlc
)
PKG_AUDIO=(
    alsa-utils # includes alsamixer utility
    pavucontrol # volume control GUI
    pipewire # audio/video router/processor - required for hyprland screen sharing
    pipewire-alsa # pipewire alsa configuration
    pipewire-audio # pipewire audio support (including bluetooth audio support)
    pipewire-pulse # pipewire as pulseaudio replacement
    playerctl # used to control audio players via hyprland keybinds
    wireplumber # pipewire session/policy manager - required for hyprland screen sharing
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
    bluez
    bluez-utils
)

PKG_LAPTOP=(
    brightnessctl
    keyd
    # thermald
    # tlp
    # xf86-input-libinput
    # xorg-xbacklight
)

PKG_NON_WORK=(
    proton-vpn-gtk-app
    steam
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
    # xedgewarp-git
)

PKG_LIBVIRT=(
    dmidecode
    dnsmasq
    iptables-nft
    libvirt
    qemu-desktop
    samba
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
    PACKAGES=("${PACKAGES[@]}" "${PKG_GRAPHICS[@]}" "${PKG_GUI_DE[@]}" "${PKG_GUI_FILEBROWSER[@]}" "${PKG_GUI_UTILS[@]}" "${PKG_GUI_APPS[@]}" "${PKG_AUDIO[@]}" "${PKG_FONTS[@]}" "${PKG_YUBIKEY[@]}" "${PKG_BLUETOOTH[@]}")

    if ($IS_LAPTOP); then
        PACKAGES=("${PACKAGES[@]}" "${PKG_LAPTOP[@]}")
    fi

    if [ "$USER" = 'jstiles' ]; then
        PACKAGES=("${PACKAGES[@]}" "${PKG_WORK[@]}" "${PKG_LIBVIRT[@]}")
    else
        PACKAGES=("${PACKAGES[@]}" "${PKG_NON_WORK[@]}")
    fi
fi

PACKAGES="${PACKAGES[@]}"
PKG_RETIRED="${PKG_RETIRED[@]}"

export PACKAGES
export PKG_RETIRED
export GRAPHICS_VENDOR
export IS_LAPTOP
export IS_DOCKER_HOST

