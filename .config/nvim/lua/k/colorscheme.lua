-- [[ colorscheme ]]

-- auto detect dark/light from OS
function dark_light_theme()
	local handle = io.popen('gsettings get org.gnome.desktop.interface color-scheme')
	local output = handle:read('*a')
	handle:close()
	output = output:gsub('\'', '')

	if string.find(output, 'dark') then
		vim.o.background = 'dark'
		-- require('themes.catppuccin')
		-- vim.cmd.colorscheme 'catppuccin'

		require('themes.tokyonight')
		vim.cmd.colorscheme 'tokyonight'

		-- vim.cmd.colorscheme 'colibri'

		-- vim.cmd.colorscheme 'default'
	else
		vim.o.background = 'light'
		require('themes.catppuccin')
		vim.cmd.colorscheme 'catppuccin-latte'

		-- vim.cmd.colorscheme 'colibri'

		-- vim.cmd.colorscheme 'default'
	end

	-- transparent background
	vim.cmd [[ hi Normal guibg=NONE ctermbg=NONE ]]
end

dark_light_theme()
