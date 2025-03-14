local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.window_background_opacity = 0.95
config.macos_window_background_blur = 0
config.initial_cols = 150
config.initial_rows = 45
config.enable_scroll_bar = false
config.window_decorations = 'RESIZE'
config.hide_tab_bar_if_only_one_tab = true

config.font = wezterm.font('CodeNewRoman Nerd Font Mono')
config.font_size = 16

config.default_cursor_style = 'BlinkingBar'

-- config.status_update_interval = 1000

-- wezterm.on(
-- 	"update-status",
-- 	function (window)
-- 		local date = wezterm.strftime '%b%-d %H:%H'
-- 		local battery_info = ""

-- 		for _, b in ipairs(wezterm.battery_info()) do
-- 			battery = battery_info .. string.format("battery %.0f%%", b-state_of_charge * 100)
-- 		end

-- 		window:set_right_status(wezterm.format({
-- 			{ Foreground = { Color = '#74c7ec' } },
-- 			{ Attribute = { Intensity = "bold" } },
-- 			{ Text = battery },
-- 			{ Text = ' ' },
-- 			{ Foreground = { Color = '#74c7ec' } },
-- 			{ Attribute = { Intensity = "bold" } },
-- 			{ Text = date },
-- 			{ Text = ' ' },
-- 		}))
-- 	end
-- )

config.use_fancy_tab_bar = false

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
	local index = tab.tab_index + 1
	return string.format("  %d  ", index)
end)

-- config.color_scheme = "Obsidian"
-- config.color_scheme = "nordfox"
config.color_scheme = "OneHalfDark"

return config
