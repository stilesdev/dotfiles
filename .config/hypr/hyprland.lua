-- https://wiki.hypr.land/Configuring/Start/

MOD = "SUPER"

TERM_PROGRAM = "wezterm"

HOSTNAME = os.getenv("HOST")
    or os.getenv("HOSTNAME")
    or (function()
        local f = io.popen("/bin/hostname")
        if f == nil then
            return ""
        end
        local hostname = f:read("*a") or ""
        f:close()
        hostname = string.gsub(hostname, "\n$", "")
        return hostname
    end)()

require("modules.monitors")
require("modules.startup-apps")
require("modules.appearance")
require("modules.layouts")
require("modules.input")
require("modules.keybinds")
require("modules.workspace-rules")
require("modules.window-rules")


-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")
