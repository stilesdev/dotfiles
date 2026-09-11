hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "future-cursors-cyan")
hl.env("HYPRCURSOR_SIZE", "24")

-- Style Qt5 and Qt6 applications using current GTK3 theme
hl.env("QT_QPA_PLATFORMTHEME", "gtk3")

-- Allow electron apps to run in wayland
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

if HOSTNAME == "arcade" then
    -- Added according to https://wiki.hypr.land/Nvidia/#environment-variables
    hl.env("LIBVA_DRIVER_NAME", "nvidia")
    hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
end
