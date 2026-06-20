-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/

hl.window_rule({
    name = "spotify-special-workspace",
    match = { class = "[Ss]potify" },
    workspace = "special:spotify silent",
    float = true,
    size = { "(monitor_w*0.75)", "(monitor_h*0.75)" },
    center = true,
    dim_around = true,
})

hl.window_rule({
    name = "clipse-floating-dialog",
    match = { class = "(clipse)" },
    float = true,
    pin = true,
    size = { 622, 652 },
})

-- Force applications to open in floating mode
hl.window_rule({ match = { title = "Yubico Authenticator" }, float = true })
hl.window_rule({ match = { class = "jetbrains-toolbox" }, float = true })

-- Make sure Thunar dialogs open floating and focused
hl.window_rule({ match = { class = "thunar", title = "File Operation Progress" }, float = true })
hl.window_rule({ match = { class = "thunar", title = "^Rename .*" }, float = true, stay_focused = true })

-- Make sure Synology Drive tray UI stays focused while open
hl.window_rule({ match = { class = "cloud-drive-ui" }, stay_focused = true })

-- Make sure pinentry stays focused
hl.window_rule({ match = { class = "(pinentry-)(.*)" }, stay_focused = true })

-- Ignore maximize requests from all apps. You'll probably like this.
hl.window_rule({
    name           = "suppress-maximize-events",
    match          = { class = ".*" },

    suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    name     = "fix-xwayland-drags",
    match    = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})


-- Open apps on specific workspaces
local function assign_window_class_to_workspace(workspace, class)
    hl.window_rule({ match = { class = class }, workspace = workspace })
end

assign_window_class_to_workspace("1", "zen")
assign_window_class_to_workspace("5", "obsidian")

if HOSTNAME == "arena" then
    assign_window_class_to_workspace("6", "firefox")
elseif HOSTNAME == "jstiles-archlinux" then
    assign_window_class_to_workspace("3", "jetbrains-phpstorm")
    assign_window_class_to_workspace("7", "Virt-manager")
    assign_window_class_to_workspace("8", "teams-for-linux")

    hl.window_rule({
        name = "cisco-vpn-main-dialogs",
        match = { class = "com.cisco.secureclient.gui" },
        workspace = "special:vpn silent",
        float = true,
        center = true,
        dim_around = true,
    })

    hl.window_rule({
        name = "cisco-vpn-login-dialog",
        match = { class = "Cisco Secure Client" },
        workspace = "special:vpn silent",
        float = true,
        center = true,
        dim_around = true,
    })
end
