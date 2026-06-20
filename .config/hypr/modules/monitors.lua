-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

if HOSTNAME == "arena" then
    -- Main monitor HDR:
    -- hl.monitor({ output = "DP-2", mode = "3440x1440@165", position = "0x0", scale = 1, bitdepth = 10, cm = "hdr", sdrbrightness = 1.15, sdrsaturation = 1.3, vrr = 2 })
    -- hl.monitor({ output = "DP-2", mode = "3440x1440@165", position = "0x0", scale = 1, bitdepth = 10, cm = "hdr", sdrbrightness = 1.15, sdrsaturation = 1.3 })

    -- Main monitor SDR:
    -- hl.monitor({ output = "DP-2", mode = "3440x1440@165", position = "0x0", scale = 1, bitdepth = 10, vrr = 2 })
    hl.monitor({ output = "DP-2", mode = "3440x1440@165", position = "0x0", scale = 1, bitdepth = 10 })

    -- Second monitor:
    hl.monitor({ output = "DP-1", mode = "3440x1440@144", position = "0x-1440", scale = 1 })
    -- hl.monitor({ output = "DP-1", disabled = true })
elseif HOSTNAME == "jstiles-archlinux" then
    -- Main monitor:
    hl.monitor({ output = "DP-1", mode = "2560x1080@85", position = "0x0", scale = 1 })

    -- Second monitor:
    -- hl.monitor({ output = "DP-2", mode = "3840x2160@60", position = "auto-center-left", scale = 1.5, transform = 1 })
    hl.monitor({ output = "DP-2", mode = "3840x2160@60", position = "auto-center-left", scale = 1.3333, transform = 1 })
    -- hl.monitor({ output = "DP-2", mode = "3840x2160@60", position = "auto-center-left", scale = 1, transform = 1 })
else
    hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })
end
