-- Global input config
-- See https://wiki.hypr.land/Configuring/Basics/Variables/#input
hl.config({
    input = {
        kb_layout          = "us",
        kb_variant         = "",
        kb_model           = "",
        kb_options         = "",
        kb_rules           = "",
        numlock_by_default = true,

        follow_mouse       = 1,

        accel_profile      = "flat",
        sensitivity        = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad           = {
            disable_while_typing = true,
            natural_scroll = true,
            tap_to_click = true,
            tap_and_drag = true,
            drag_lock = 1,
        },
    },
})

-- Touchpad gestures
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/
hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

-- Per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/
hl.device({
    -- touchpad on MSI GF63 8RD laptop
    name = "cust0001:00-04f3:30aa-touchpad",
    accel_profile = "adaptive",
})
