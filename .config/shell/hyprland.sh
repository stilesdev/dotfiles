if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    if command -v start-hyprland > /dev/null 2>&1; then
        exec start-hyprland
    fi
fi
