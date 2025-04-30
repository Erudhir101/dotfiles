-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action
-- This will hold the configuration
local config = wezterm.config_builder()

-- font config
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 14

--terminal config
config.window_decorations = "RESIZE"
config.window_close_confirmation = "AlwaysPrompt"
config.scrollback_lines = 3000
config.default_workspace = "main"

-- Colorscheme
local mocha = wezterm.color.get_default_colors()["Catppuccin Mocha"]
config.color_scheme = "Catppuccin Mocha"
config.colors = {
	tab_bar = {
		background = "#1e1e2e",
	},
}

config.inactive_pane_hsb = {
	brightness = 0.5,
}

-- keymaps
-- config.leader = { key = "s", mods = "CTRL", timeout_milliseconds = 1000 }
-- config.keys = {
-- 	-- Pane keybindings
-- 	{ key = "q", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
--
-- 	-- Tab keybindings
-- 	{ key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
-- 	{ key = "h", mods = "ALT", action = act.ActivateTabRelative(-1) },
-- 	{ key = "l", mods = "ALT", action = act.ActivateTabRelative(1) },
-- }

-- Tab bar
-- I don't like the look of "fancy" tab bar
config.use_fancy_tab_bar = false
config.status_update_interval = 1000
config.tab_bar_at_bottom = false
wezterm.on("update-status", function(window, pane)
	-- Workspace name
	local stat = window:active_workspace()
	local stat_color = "#f38ba8"
	-- It's a little silly to have workspace name all the time
	-- Utilize this to display LDR or current key table name
	if window:active_key_table() then
		stat = window:active_key_table()
		stat_color = "#7dcfff"
	end
	if window:leader_is_active() then
		stat = "LDR"
		stat_color = "#cba6f7"
	end

	local basename = function(s)
		-- Nothing a little regex can't fix
		return string.gsub(s, "(.*[/\\])(.*)", "%2")
	end

	-- Current working directory
	local cwd = pane:get_current_working_dir()
	if cwd then
		if type(cwd) == "userdata" then
			-- Wezterm introduced the URL object in 20240127-113634-bbcac864
			cwd = basename(cwd.file_path)
		else
			-- 20230712-072601-f4abf8fd or earlier version
			cwd = basename(cwd)
		end
	else
		cwd = ""
	end

	-- Current command
	local cmd = pane:get_foreground_process_name()
	-- CWD and CMD could be nil (e.g. viewing log using Ctrl-Alt-l)
	cmd = cmd and basename(cmd) or ""

	-- Time
	local time = wezterm.strftime("%H:%M")

	-- Left status (left of the tab line)
	window:set_left_status(wezterm.format({
		{ Foreground = { Color = stat_color } },
		{ Text = "  " },
		{ Text = wezterm.nerdfonts.oct_table .. "  " .. stat },
		{ Text = " |" },
	}))

	-- Right status
	window:set_right_status(wezterm.format({
		-- Wezterm has a built-in nerd fonts
		-- https://wezfurlong.org/wezterm/config/lua/wezterm/nerdfonts.html
		{ Text = wezterm.nerdfonts.md_folder .. "  " .. cwd },
		{ Text = " | " },
		{ Foreground = { Color = "#fab387" } },
		{ Text = wezterm.nerdfonts.fa_code .. "  " .. cmd },
		"ResetAttributes",
		{ Text = " | " },
	}))
end)

return config
