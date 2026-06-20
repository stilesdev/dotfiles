-- See https://wiki.hypr.land/Configuring/Basics/Binds/

hl.bind(MOD .. " + Return", hl.dsp.exec_cmd(TERM_PROGRAM))
hl.bind(MOD .. " + SHIFT + Q", hl.dsp.window.close())
-- hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exit())
-- hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("uwsm stop"))
hl.bind(MOD .. " + SHIFT + E", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || uwsm stop"))
hl.bind(MOD .. " + SHIFT + Space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(MOD .. " + D", hl.dsp.exec_cmd("ulauncher-toggle"))
hl.bind(MOD .. " + SHIFT + X", hl.dsp.exec_cmd("hyprlock"))
hl.bind(MOD .. " + P", hl.dsp.window.pseudo())
hl.bind(MOD .. " + J", hl.dsp.layout("togglesplit")) -- dwindle only

-- Generate a UUID and copy to clipboard 
hl.bind(MOD .. " + U", hl.dsp.exec_cmd("uuidgen | tr -d '[:space:]' | wl-copy && notify-send -u low -t 2000 -i clipboard 'uuidgen' 'copied new UUID to clipboard'"))

-- Move focus with mainMod + arrow keys or h/j/k/l
hl.bind(MOD .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(MOD .. " + H",     hl.dsp.focus({ direction = "left" }))
hl.bind(MOD .. " + down",  hl.dsp.focus({ direction = "down" }))
hl.bind(MOD .. " + J",     hl.dsp.focus({ direction = "down" }))
hl.bind(MOD .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(MOD .. " + K",     hl.dsp.focus({ direction = "up" }))
hl.bind(MOD .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(MOD .. " + L",     hl.dsp.focus({ direction = "right" }))

-- Move window with mainMod + SHIFT + arrow keys or h/j/k/l
hl.bind(MOD .. " + SHIFT + left",  hl.dsp.window.swap({ direction = "left" }))
hl.bind(MOD .. " + SHIFT + H",     hl.dsp.window.swap({ direction = "left" }))
hl.bind(MOD .. " + SHIFT + down",  hl.dsp.window.swap({ direction = "down" }))
hl.bind(MOD .. " + SHIFT + J",     hl.dsp.window.swap({ direction = "down" }))
hl.bind(MOD .. " + SHIFT + up",    hl.dsp.window.swap({ direction = "up" }))
hl.bind(MOD .. " + SHIFT + K",     hl.dsp.window.swap({ direction = "up" }))
hl.bind(MOD .. " + SHIFT + right", hl.dsp.window.swap({ direction = "right" }))
hl.bind(MOD .. " + SHIFT + L",     hl.dsp.window.swap({ direction = "right" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(MOD .. " + " .. key,             hl.dsp.focus({ workspace = i }))
    hl.bind(MOD .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(MOD .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(MOD .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Move focused workspace to next/prev monitor
hl.bind(MOD .. " + CTRL + left", hl.dsp.workspace.move({ monitor = "-1" }))
hl.bind(MOD .. " + CTRL + right", hl.dsp.workspace.move({ monitor = "+1" }))

-- Toggle fullscreen for window
hl.bind(MOD .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(MOD .. " + B", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))

-- Toggle spotify special workspace
hl.bind(MOD .. " + minus", hl.dsp.workspace.toggle_special("spotify"))

-- Toggle notification panel
hl.bind(MOD .. " + N", hl.dsp.exec_cmd("swaync-client -t -sw"))

-- Toggle clipboard history
hl.bind(MOD .. " + C", hl.dsp.exec_cmd("pkill clipse || wezterm start --class clipse -e 'clipse'"))

-- Screenshots
hl.bind("Print", hl.dsp.exec_cmd("hyprshot -m active -m output -r -z | swappy -f -"))
hl.bind("CTRL + Print", hl.dsp.exec_cmd("hyprshot -m region -r -z | swappy -f -"))
hl.bind("ALT + Print", hl.dsp.exec_cmd("hyprshot -m active -m window -r -z | swappy -f -"))

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { locked = true, repeating = true })

-- Media controls (requires playerctl)
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl -p spotify next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl -p spotify play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl -p spotify play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl -p spotify previous"), { locked = true })

-- Switch to other TTY
for i = 1, 6 do
    hl.bind("ALT + F" .. i, hl.dsp.exec_cmd("sudo chvt " .. i))
end


-- Extra per-host keybinds
if HOSTNAME == "gallium" then
    hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
elseif HOSTNAME == "jstiles-archlinux" then
    hl.bind("XF86Tools", hl.dsp.exec_cmd("pactl set-source-mute alsa_input.usb-C-Media_Electronics_Inc._InnoGear_UC016-00.mono-fallback toggle"))
    hl.bind(MOD.." + Tab", hl.dsp.workspace.toggle_special("vpn"))
else
    hl.bind("XF86Tools", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
end
