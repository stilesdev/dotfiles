-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function()
    -- from https://gist.github.com/brunoanc/2dea6ddf6974ba4e5d26c3139ffb7580
    -- make sure that xdg-desktop-portal-hyprland can get the required variables on startup (for screen sharing)
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

    -- apply theme to gsettings using values selected in nwg-look (stored in ~/.local/share/nwg-look/gsettings)
    hl.exec_cmd("nwg-look -a")

    -- set mouse cursor https://wiki.hypr.land/FAQ/#how-do-i-change-me-mouse-cursor
    hl.exec_cmd("hyprctl setcursor 'Breeze_Hacked' 16")

    -- tray apps
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("udiskie")

    -- launcher
    hl.exec_cmd("ulauncher --hide-window --no-window-shadow")

    -- clipboard history daemon
    hl.exec_cmd("clipse -listen")

    -- GUI apps
    hl.exec_cmd("zen-browser")
    hl.exec_cmd(TERM_PROGRAM, { workspace = "2 silent" })
    hl.exec_cmd("spotify")

    if HOSTNAME == "arena" then
        hl.exec_cmd("firefox")
    elseif HOSTNAME == "jstiles-archlinux" then
        hl.exec_cmd(TERM_PROGRAM, { workspace = "4" })
        hl.exec_cmd("obsidian", { workspace = "5 silent" })
        -- hl.exec_cmd("virt-manager --connect qemu:///system --show-domain-console win10")
        hl.exec_cmd("sh -c 'LD_LIBRARY_PATH=/opt/cisco/secureclient/lib:$LD_LIBRARY_PATH /opt/cisco/secureclient/bin/vpnui'")

        -- added sleep for these to make sure waybar starts first, else tray icons never show up
        hl.exec_cmd("sleep 3 && synology-drive")
        hl.exec_cmd("sleep 3 && teams-for-linux", { workspace = "8 silent" })
    end
end)
