-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = 'Catppuccin Mocha'

config.enable_tab_bar = false

config.window_padding = {
	left = 4,
	right = 4,
	top = 2,
	bottom = 2,
}

config.font = wezterm.font 'Hasklug Nerd Font'

config.font_size = 9

config.window_background_opacity = 0.95

config.front_end = 'WebGpu'

config.scrollback_lines = 999999

config.skip_close_confirmation_for_processes_named = {
    'bash',
    'sh',
    'zsh',
    'tmux',
    'sessionizer',
}

-- and finally, return the configuration to wezterm
return config
