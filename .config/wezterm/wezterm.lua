-- local colors = require('lua/rose-pine').colors()
-- local window_frame = require('lua/rose-pine').window_frame()
local wezterm = require 'wezterm'

wezterm.on('user-var-changed', function(window, pane, name, value)
	local overrides = window:get_config_overrides() or {}
	if name == "ZEN_MODE" then
		local incremental = value:find("+")
		local number_value = tonumber(value)
		if incremental ~= nil then
			while (number_value > 0) do
				window:perform_action(wezterm.action.IncreaseFontSize, pane)
				number_value = number_value - 1
			end
			overrides.enable_tab_bar = false
		elseif number_value < 0 then
			window:perform_action(wezterm.action.ResetFontSize, pane)
			overrides.font_size = nil
			overrides.enable_tab_bar = true
		else
			overrides.font_size = number_value
			overrides.enable_tab_bar = false
		end
	end
	window:set_config_overrides(overrides)
end)
function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return 'Dark'
end

function scheme_for_appearance(appearance)
	if appearance:find "Light" then
		-- return "Catppuccin Latte"
		-- return "Rosé Pine Dawn (base16)"
		return 'Tokyo Night Day'
	else
		-- return "Catppuccin Mocha"
		-- return "Rosé Pine (base16)"
		return 'Tokyo Night'
	end
end

return {
	enable_scroll_bar = false,
	default_cursor_style = 'BlinkingBlock',
	animation_fps = 75,
	cursor_blink_rate = 500,
	-- tabs
	use_fancy_tab_bar = true,
	hide_tab_bar_if_only_one_tab = false,
	show_new_tab_button_in_tab_bar = true,
	tab_max_width = 16,
	show_tab_index_in_tab_bar = false,

	colors = {
		tab_bar = {
			-- The color of the inactive tab bar edge/divider
			inactive_tab_edge = '#575757',
			active_tab = {
				italic = true,
				bg_color = '#444444',
				fg_color = '#BDBDBD',
			},
		},
	},

	inactive_pane_hsb = {
		saturation = 0.9,
		brightness = 0.8,
	},

	-- fancy tab bar style
	window_frame = {
		font = wezterm.font 'Cantarell',
		font_size = 12.0,
		active_titlebar_bg = '#303030',
		inactive_titlebar_bg = '#242424',
	},

	--[[ window_background_gradient = {
		colors = { '#1A1B26', '#12131B' },
		-- Specifices a Linear gradient starting in the top left corner.
		orientation = { Linear = { angle = -45.0 } },
	}, ]]

	font = wezterm.font_with_fallback {
		{
			family = 'Cascadia Code PL',
			weight = 'Regular',
			harfbuzz_features = { 'calt', 'ss01', 'ss20' }
		},

		{
			family = 'Fira Code',
			weight = 'Regular',
			harfbuzz_features = { 'cv01', 'cv06', 'cv09', 'zero', 'cv14', 'ss04', 'cv16', 'cv31', 'cv30',
				'ss02', 'ss09', 'cv25', 'cv25', 'cv26', 'cv32', 'cv27', 'ss06', 'ss07' }
		},

		{
			family = 'JetBrains Mono',
			weight = 'Regular',
			harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
		},

		{
			family = 'Terminus',
			weight = 'Medium'
		},

		{
			family = 'Source Code Pro',
			weight = 'Medium'
		},

		'Noto Color Emoji',
	},

	color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),

	window_background_opacity = 0.9,

	window_padding = {
		left = '2cell',
		right = '2cell',
		top = '0.5cell',
		bottom = '0.5cell',
	},

	window_decorations = "RESIZE|INTEGRATED_BUTTONS",
	integrated_title_buttons = { 'Close' },
	integrated_title_button_style = 'Gnome',

	webgpu_power_preference = "HighPerformance",

	keys = {
		{
			key = 't', -- 'tab'
			mods = 'ALT',
			action = wezterm.action.SpawnTab 'CurrentPaneDomain',
		},

		{
			key = 'n', -- 'new'
			mods = 'ALT',
			action = wezterm.action.SpawnWindow
		},

		{
			key = 'v', -- 'vertical'
			mods = 'ALT',
			action = wezterm.action.SplitPane {
				direction = 'Right',
				-- command = { args = { 'htop' } },
				size = { Percent = 50 },
			},
		},

		{
			key = 'h', -- 'horizontal'
			mods = 'ALT',
			action = wezterm.action.SplitPane {
				direction = 'Down',
				-- command = { args = { 'htop' } },
				size = { Percent = 50 },
			},
		},

		{
			key = 'c', -- 'choose'
			mods = 'ALT',
			action = wezterm.action.PaneSelect {
				alphabet = '1234567890',
			},

		},

		{
			key = 'l',
			mods = 'ALT',
			action = wezterm.action.ShowLauncher
		},

		{
			key = 'f', -- 'fullscreen'
			mods = 'ALT',
			action = wezterm.action.ToggleFullScreen,
		},
	},
}
