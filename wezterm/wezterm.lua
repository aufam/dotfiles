local wezterm = require("wezterm")

return {
	default_prog = { "sh", "-c", "~/.config/tmux/scripts/launch.sh" },

	font = wezterm.font("Space Mono"),
	font_size = 12.0,

	window_decorations = "RESIZE",
	window_background_opacity = 0.75,

	line_height = 1.3,
	cell_width = 1.0,

	color_scheme = "Google Dark (base16)",
	colors = { background = "#000000" },

	enable_tab_bar = false,
	disable_default_key_bindings = true,
	keys = {
		{
			key = "C",
			mods = "CTRL|SHIFT",
			action = wezterm.action.CopyTo("Clipboard"),
		},
		{
			key = "V",
			mods = "CTRL|SHIFT",
			action = wezterm.action.PasteFrom("Clipboard"),
		},
	},
}
