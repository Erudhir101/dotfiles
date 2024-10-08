-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration
local config = wezterm.config_builder()

-- font config
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 14

-- config.window_decorations = "NONE"

-- Colorscheme
config.color_scheme = "Catppuccin Mocha"

return config
