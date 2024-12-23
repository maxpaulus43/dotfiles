-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local c = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	c = wezterm.config_builder()
end

-- This is where you actually apply your config choices
c.front_end = "WebGpu"

local my_brogrammer = wezterm.color.get_builtin_schemes()["Brogrammer"]
my_brogrammer.selection_fg = "black"
my_brogrammer.selection_bg = "#B164B2"
c.color_schemes = {
	["My Brogrammer"] = my_brogrammer,
}
c.color_scheme = "My Brogrammer"

c.font_size = 15.0
c.font = wezterm.font("Hack Nerd Font Mono")

-- don't use ligatures
c.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

c.tab_bar_at_bottom = true
c.use_fancy_tab_bar = false
-- c.initial_rows = 80
-- c.initial_cols = 160
c.scrollback_lines = 20000
c.inactive_pane_hsb = {
	saturation = 0.8,
	brightness = 0.5,
}
c.window_padding = {
	left = 0,
	right = 0,
	bottom = 0,
	top = 0,
}
c.keys = {
	{
		key = "F1",
		mods = "",
		action = wezterm.action.TogglePaneZoomState,
	},
	{
		key = "Enter",
		mods = "CMD|ALT",
		action = wezterm.action.SplitPane({
			direction = "Up",
			top_level = true,
			command = { domain = "CurrentPaneDomain" },
		}),
	},
	{ key = "Enter", mods = "ALT", action = wezterm.action.DisableDefaultAssignment },
	{
		key = "Enter",
		mods = "CMD",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "Enter",
		mods = "CMD|SHIFT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "k",
		mods = "CMD",
		action = wezterm.action.ClearScrollback("ScrollbackAndViewport"),
	},
	{
		key = "k",
		mods = "CMD|SHIFT",
		action = wezterm.action.ClearScrollback("ScrollbackOnly"),
	},
	{
		key = "l",
		mods = "CTRL|ALT",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		key = "h",
		mods = "CTRL|ALT",
		action = wezterm.action.ActivateTabRelative(-1),
	},
}

-- and finally, return the configuration to wezterm
return c
