-- See https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

local function bind_workspace_to_monitor(workspace, monitor)
    hl.workspace_rule({ workspace = workspace, monitor = monitor })
end

if HOSTNAME == "arena" then
    local top = "DP-1"
    local bottom = "DP-2"
    bind_workspace_to_monitor("1", bottom)
    bind_workspace_to_monitor("2", bottom)
    bind_workspace_to_monitor("3", bottom)
    bind_workspace_to_monitor("4", bottom)
    bind_workspace_to_monitor("5", bottom)
    bind_workspace_to_monitor("6", top)
    bind_workspace_to_monitor("7", top)
    bind_workspace_to_monitor("8", top)
    bind_workspace_to_monitor("9", top)
    bind_workspace_to_monitor("10", top)
elseif HOSTNAME == "jstiles-archlinux" then
    local left = "DP-2"
    local right = "DP-1"
    bind_workspace_to_monitor("1", right)
    bind_workspace_to_monitor("2", right)
    bind_workspace_to_monitor("3", left)
    bind_workspace_to_monitor("4", left)
    bind_workspace_to_monitor("5", left)
    bind_workspace_to_monitor("6", right)
    bind_workspace_to_monitor("7", right)
    bind_workspace_to_monitor("8", right)
    bind_workspace_to_monitor("9", right)
    bind_workspace_to_monitor("10", right)
end
