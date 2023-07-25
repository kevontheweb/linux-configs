-- local colors = require('lua/rose-pine').colors()
-- local window_frame = require('lua/rose-pine').window_frame()
local wezterm = require 'wezterm'

function scheme_for_appearance(appearance)
  if appearance:find "Dark" then
    -- return "Catppuccin Mocha"
    -- return "Rosé Pine (base16)"
    return 'tokyonight_night'
  else
    -- return "Catppuccin Latte"
    -- return "Rosé Pine Dawn (base16)"
    return 'tokyonight_day'
  end
end

return {
  use_fancy_tab_bar = true,
  -- window_frame = window_frame, -- needed only if using fancy tab bar
  window_frame = {
    font = wezterm.font 'CaskaydiaCove Nerd Font',
    font_size = 10.0,
    active_titlebar_bg = '#1A1B26',
    inactive_titlebar_bg = '#1A1B26',
  },

  -- font = wezterm.font 'BlexMono Nerd Font',
  font = wezterm.font 'CaskaydiaCove Nerd Font',
  color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
  window_background_opacity = 1,
  hide_tab_bar_if_only_one_tab = true,
  window_padding = {
    left = '2cell',
    right = '2cell',
    top = '1.5cell',
    bottom = '0.5cell',
  },
  window_decorations = "RESIZE|TITLE"
}
