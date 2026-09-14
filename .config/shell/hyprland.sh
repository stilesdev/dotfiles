if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    if command -v start-hyprland > /dev/null 2>&1; then
        exec start-hyprland
    fi
fi

if [ -n "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
    alias shutdown="hyprshutdown --top-label 'Shutting down...' --post-cmd 'shutdown -h now'"
    alias reboot="hyprshutdown --top-label 'Rebooting...' --post-cmd 'reboot'"
fi
