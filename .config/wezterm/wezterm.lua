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

wezterm.on('toggle-opacity', function(window, pane)
	local overrides = window:get_config_overrides() or {}
	if overrides.window_background_opacity ~= 1 then
		overrides.window_background_opacity = 1
	else
		overrides.window_background_opacity = 0.925
	end
	window:set_config_overrides(overrides)
end)


function scheme_for_appearance(appearance)
	if appearance:find "Light" then
		-- return "Catppuccin Latte"
		-- return 'Kanagawa (Gogh)'
		-- return 'Tokyo Night'
		return 'Oxocarbon Light'
		-- return 'Borland'
		-- return 'PhD (base16)'
		-- return 'Carbonfox Light'
		-- return 'wez'
	else
		-- return "Catppuccin Mocha"
		-- return 'Kanagawa (Gogh)'
		-- return 'Tokyo Night'
		return 'Oxocarbon Dark'
		-- return 'Carbonfox Dark'
		-- return 'Borland'
		-- return 'PhD (base16)'
		-- return 'carbonfox'
		-- return 'wez'
	end
end

if get_appearance() == 'Dark' then
	appearance = {
		cmd_palette_fg_color = '#BDBDBD',
		cmd_palette_bg_color = 'rgba(36, 36, 36, 1)',
		inactive_tab_edge = '#575757',
		bg_color = '#444444',
		fg_color = '#BDBDBD',
		alt_bg_color = '#303030',
		alt_fg_color = '#BDBDBD',
		active_titlebar_bg = '#303030',
		inactive_titlebar_bg = '#242424',
	}
else
	appearance = {
		cmd_palette_fg_color = '#2F2F2F',
		cmd_palette_bg_color = 'rgba(235, 235, 235, 1)',
		inactive_tab_edge = '#D4D4D4',
		bg_color = '#D4D4D4',
		fg_color = '#2F2F2F',
		alt_bg_color = '#EBEBEB',
		alt_fg_color = '#949494',
		active_titlebar_bg = '#EBEBEB',
		inactive_titlebar_bg = '#FAFAFA',
	}
end

return {
	enable_scroll_bar = false,
	default_cursor_style = 'BlinkingBlock',
	animation_fps = 60,
	cursor_blink_rate = 400,
	force_reverse_video_cursor = true,
	pane_focus_follows_mouse = true,
	switch_to_last_active_tab_when_closing_tab = true,
	-- tabs
	use_fancy_tab_bar = true,
	hide_tab_bar_if_only_one_tab = false,
	show_new_tab_button_in_tab_bar = true,

	initial_rows = 34,
	initial_cols = 120,

	colors = {
		tab_bar = {
			-- The color of the inactive tab bar edge/divider
			inactive_tab_edge = appearance.inactive_tab_edge,
			inactive_tab = {
				bg_color = appearance.alt_bg_color,
				fg_color = appearance.alt_fg_color,
			},
			inactive_tab_hover = {
				bg_color = appearance.bg_color,
				fg_color = appearance.alt_fg_color,
			},
			active_tab = {
				italic = true,
				bg_color = appearance.bg_color,
				fg_color = appearance.fg_color,
			},
			new_tab = {
				bg_color = appearance.alt_bg_color,
				fg_color = appearance.fg_color,
			},
			new_tab_hover = {
				bg_color = appearance.bg_color,
				fg_color = appearance.alt_fg_color,
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
		active_titlebar_bg = appearance.active_titlebar_bg,
		inactive_titlebar_bg = appearance.inactive_titlebar_bg,
	},

	--[[ window_background_gradient = {
		colors = { '#1A1B26', '#12131B' },
		-- Specifices a Linear gradient starting in the top left corner.
		orientation = { Linear = { angle = -45.0 } },
	}, ]]

	font_size = 12,
	-- cell_width = 1.1,
	font = wezterm.font_with_fallback {
		{
			family = 'Maple Mono',
			weight = 'Regular',
			harfbuzz_features = { 'cv01', 'ss01', 'ss02', 'ss03', 'ss04' }
		},
		{
			family = 'Victor Mono',
			weight = 'DemiBold',
			harfbuzz_features = { 'ss01', 'ss05', 'ss07' }
		},
		{
			family = 'IBM Plex Mono',
			weight = 'DemiBold'
		},
		{
			family = 'Terminus',
			weight = 'Regular'
		},
		{
			family = 'CozetteVector',
		},
		{
			family = 'Fira Code',
			weight = 'Medium',
			harfbuzz_features = { 'cv01', 'cv06', 'cv09', 'zero', 'cv14', 'ss04', 'cv16', 'cv31', 'cv30',
				'ss02', 'ss09', 'cv25', 'cv25', 'cv26', 'cv32', 'cv27', 'ss06', 'ss07' }
		},
		{
			family = 'JetBrains Mono',
			weight = 'DemiBold',
			harfbuzz_features = { 'calt', 'clig', 'liga' },
		},
		{
			family = 'Cascadia Mono PL',
			weight = 'Regular',
			harfbuzz_features = { 'calt', 'ss01', 'ss20' }
		},
		{
			family = 'Comic Mono',
			weight = 'Regular',
		},
		{
			family = 'IBM Plex Mono',
			weight = 'Medium',
		},
	},
	--[[ font_rules = {
		-- fall back on Cascadia Code for italics
		{
			intensity = 'Bold',
			italic = true,
			font = wezterm.font {
				family = 'Cascadia Code PL',
				weight = 'Bold',
				style = 'Italic',
				harfbuzz_features = { 'calt', 'ss01', 'ss20' }
			},
		},
		{
			intensity = 'Half',
			italic = true,
			font = wezterm.font {
				family = 'Cascadia Code PL',
				weight = 'Medium',
				style = 'Italic',
				harfbuzz_features = { 'calt', 'ss01', 'ss20' }
			},
		},
		{
			intensity = 'Normal',
			italic = true,
			font = wezterm.font {
				family = 'Cascadia Code PL',
				style = 'Italic',
				harfbuzz_features = { 'calt', 'ss01', 'ss20' }
			},
		},
	}, ]]


	color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),

	window_background_opacity = 1,

	window_padding = {
		left = '1cell',
		right = '1cell',
		top = '0.5cell',
		bottom = '0.5cell',
	},

	window_decorations = "INTEGRATED_BUTTONS",
	integrated_title_buttons = { 'Close' },
	integrated_title_button_style = 'Gnome',
	command_palette_fg_color = appearance.cmd_palette_fg_color,
	command_palette_bg_color = appearance.cmd_palette_bg_color,

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
			key = 'w',
			mods = 'ALT',
			action = wezterm.action.CloseCurrentPane { confirm = true },
		},

		{
			key = 'q',
			mods = 'CMD',
			action = wezterm.action.CloseCurrentTab { confirm = true },
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

		{
			key = 'P',
			mods = 'CTRL',
			action = wezterm.action.ActivateCommandPalette,
		},

		{
			key = '~',
			mods = 'CTRL',
			action = wezterm.action.ActivatePaneDirection 'Next',
		},

		{
			key = 'o',
			mods = 'ALT',
			action = wezterm.action.EmitEvent 'toggle-opacity',
		},
	},
}
