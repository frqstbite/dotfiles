local wezterm = require('wezterm')

local config = wezterm.config_builder()
--config.allow_square_glyphs_to_overflow_width = "Never"
config.color_scheme = 'Catppuccin Mocha'
config.font = wezterm.font_with_fallback({
	'Maple Mono',
	'Fira Code',
	'JetBrains Mono',
	'Symbols Nerd Font Mono'
})
config.font_size = 11.0
config.initial_cols = 120
config.initial_rows = 30

-- --- WINDOW CUSTOMIZATION ---
config.window_background_opacity = 0.90
config.window_decorations = "TITLE | RESIZE"
config.hide_tab_bar_if_only_one_tab = true

-- --- WINDOWS SPECIFIC DEFAULTS ---
config.default_prog = {
	'C:\\Windows\\system32\\wsl.exe',
	'--distribution-id',
	'{c12d737a-a570-4232-9d77-f2767ff9f6bf}',
	'--cd',
	'~'
}

return config
