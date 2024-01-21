require('tokyonight').setup({
	style = 'night',
	light_style = 'day',
	transparent = true,
	terminal_colors = false, -- Configure the colors used when opening a `:terminal` in Neovim
	styles = {
		comments = { italic = true },
		keywords = { italic = false },
		functions = { italic = true },
		variables = {},
		sidebars = 'dark',
		floats = 'dark',
	},
	hide_inactive_statusline = true,
	dim_inactive = true, -- dims inactive windows
	on_highlights = function(hl, colors)
		hl.DiagnosticUnderlineError.undercurl = false
		hl.DiagnosticUnderlineError.underline = true
		hl.DiagnosticUnderlineWarn.undercurl = false
		hl.DiagnosticUnderlineWarn.underline = true
		hl.DiagnosticUnderlineInfo.undercurl = false
		hl.DiagnosticUnderlineInfo.underline = true
		hl.DiagnosticUnderlineHint.undercurl = false
		hl.DiagnosticUnderlineHint.underline = true
		hl.DiagnosticVirtualTextError.bg = colors.none
		hl.DiagnosticVirtualTextWarn.bg = colors.none
		hl.DiagnosticVirtualTextInfo.bg = colors.none
		hl.DiagnosticVirtualTextHint.bg = colors.none
	end,
	on_colors = function(colors)
		colors.border = colors.fg_dark
	end
})
