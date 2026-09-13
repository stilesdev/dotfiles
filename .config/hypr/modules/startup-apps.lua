-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- TODO: remove these manual start/stop commands once Hyprland releases >0.56.2 which handles this directly
-- (also remove the file ~/.config/systemd/user/hyprland-session.target and commit the delete to yadm)
--      (.config/systemd/user/hyprland-session.target.d/override.conf should remain as an override to enable .desktop file autostart capabilities)

hl.on("hyprland.start", function()
    hl.exec_cmd("systemctl --user start hyprland-session.target")
end)
hl.on("hyprland.shutdown", function()
    os.execute("systemctl --user stop hyprland-session.target && sleep 0.1")
end)

hl.on("hyprland.start", function()
    -- Set -1000 oom score to prevent Hyprland from being killed early when system runs out of memory
    hl.exec_cmd("sudo choom -n -1000 -p $PPID")

    -- from https://gist.github.com/brunoanc/2dea6ddf6974ba4e5d26c3139ffb7580
    -- make sure that xdg-desktop-portal-hyprland can get the required variables on startup (for screen sharing)
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

    -- apply theme to gsettings using values selected in nwg-look (stored in ~/.local/share/nwg-look/gsettings)
    hl.exec_cmd("nwg-look -a")

    -- set mouse cursor https://wiki.hypr.land/FAQ/#how-do-i-change-me-mouse-cursor
    hl.exec_cmd("hyprctl setcursor 'future-cursors-cyan' 24")

    -- tray apps
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("udiskie")

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
