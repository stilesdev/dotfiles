#!/usr/bin/env bash

GRAPHICS_VENDOR=''
IS_LAPTOP=false
IS_VPS=false
IS_DOCKER_HOST=false

case $(hostname) in
arcade*)
    GRAPHICS_VENDOR='nvidia-580xx'
    IS_LAPTOP=true
    IS_DOCKER_HOST=true
    ;;
arena*)
    GRAPHICS_VENDOR='nvidia'
    IS_DOCKER_HOST=true
    ;;
builder*)
    GRAPHICS_VENDOR='none'
    IS_DOCKER_HOST=true
    ;;
encom*)
    GRAPHICS_VENDOR='none'
    IS_DOCKER_HOST=true
    ;;
jstiles-archlinux*)
    GRAPHICS_VENDOR='amd'
    IS_DOCKER_HOST=true
    ;;
outlands*)
    GRAPHICS_VENDOR='none'
    IS_VPS=true
    IS_DOCKER_HOST=true
    ;;
portal*)
    GRAPHICS_VENDOR='none'
    ;;
purgos*)
    GRAPHICS_VENDOR='none'
    ;;
test*)
    GRAPHICS_VENDOR='none'
    IS_DOCKER_HOST=true
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
        nvidia-open # official open-source kernel modules from NVIDIA
        nvidia-utils # userspace drivers, including Vulkan support
    )
elif [ "$GRAPHICS_VENDOR" = 'nvidia-580xx' ]; then
    PKG_GRAPHICS=(
        egl-wayland # NVIDIA Wayland implementation of EGL, required by hyprland
        lib32-nvidia-580xx-utils # 32-bit userspace drivers, for apps like Steam and Wine
        linux-headers # needed for dkms
        nvidia-580xx-dkms # official closed-source driver from NVIDIA
        nvidia-580xx-utils # userspace drivers, including Vulkan support
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
    sshfs # mount remote filesystems using SSH
    systemd-boot-pacman-hook # pacman hook to upgrade systemd-boot after systemd upgrades
    usbutils # lsusb
    zram-generator # automatic setup of zram as swap
)
PKG_UTILS=(
    autossh
    bat
    cloc
    git
    git-filter-repo
    gnupg
    htop
    iftop
    imagemagick
    jq
    ldns # provides drill command
    lostfiles
    nmap
    openssh
    reflector
    rsync
    smartmontools
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
    fastfetch
    fnm-bin
    fzf
    go
    jq
    kitty
    neovim
    postgresql-libs
    ripgrep
    sqlc
    starship
    tig
    tmux
    vim
    wezterm-git
    zsh
    zsh-autosuggestions
    zsh-history-substring-search
    zsh-syntax-highlighting
    zsh-vi-mode
)

# GUI Packages
PKG_GUI_DE=(
    cups # printer daemon
    cups-pdf # print to PDF
    hypridle # idle management daemon
    hyprland # main Wayland compositor
    hyprlock # screen lock
    hyprpaper # wallpaper utility
    hyprpicker # color picker, also used by hyprshot to freeze screen during screenshot
    hyprpolkitagent # polkit auth daemon (for GUI apps to request elevation)
    hyprshot # screenshot-taking utility
    network-manager-applet # tray applet for networkmanager
    nwg-look # GTK settings editor
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
PKG_GUI_THEME=(
    breeze-hacked-cursor-theme-git # cursor theme
    candy-icons-git # gtk icon theme
    gnome-themes-extra # adwaita gtk theme
#     qt5-styleplugins
    sweet-folders-icons-git # gtk folder icon theme (inherits other icons from candy-icons)
    sweet-gtk-theme-dark # gtk theme
    xcursor-neutral # cursor theme
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
    # arandr
    # autorandr
    clipse
    eog
    # flameshot
    # kcalc
    mediainfo-gui
    # numlockx
    seahorse
    wl-clipboard # terminal clipboard utilities (wl-copy and wl-paste)
    yubico-authenticator-bin
)
PKG_GUI_APPS=(
    filelight
    firefox
    gimp
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
    brave-bin
    proton-vpn-gtk-app
    steam
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
    git-lfs
    github-cli
    google-chrome
    insomnium-bin # HTTP client
    jetbrains-toolbox
    kcachegrind
    kubectl
    k9s # k8s management TUI
    miller # command-line csv processing
    minikube
    navi
    nmap
    php
    postgresql-libs
    powerpanel # UPS monitoring
    storageexplorer
    synology-drive
    teams-for-linux
    timeshift
    visual-studio-code-bin
    # xedgewarp-git
    xorg-xhost # required to run timeshift GUI on wayland
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

# Packages installed by default in the arch-boxes images, used to install Arch on a VPS
PKG_VPS=(
    btrfs-progs
    cloud-guest-utils
    cloud-init
    dosfstools
    efibootmgr
    grub
)

# Installed on all systems
PACKAGES=("${PKG_SYSTEM[@]}" "${PKG_UTILS[@]}" "${PKG_CLI[@]}")

if ($IS_DOCKER_HOST); then
    PACKAGES=("${PACKAGES[@]}" "${PKG_DOCKER[@]}")
fi

if [ "$GRAPHICS_VENDOR" != 'none' ]; then
    # Installed only on GUI systems
    PACKAGES=("${PACKAGES[@]}" "${PKG_GRAPHICS[@]}" "${PKG_GUI_DE[@]}" "${PKG_GUI_THEME[@]}" "${PKG_GUI_FILEBROWSER[@]}" "${PKG_GUI_UTILS[@]}" "${PKG_GUI_APPS[@]}" "${PKG_AUDIO[@]}" "${PKG_FONTS[@]}" "${PKG_YUBIKEY[@]}" "${PKG_BLUETOOTH[@]}")

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

if ($IS_VPS); then
    PACKAGES=("${PACKAGES[@]}" "${PKG_VPS[@]}")
fi

PACKAGES="${PACKAGES[@]}"

export PACKAGES
export GRAPHICS_VENDOR
export IS_LAPTOP
export IS_VPS
export IS_DOCKER_HOST

