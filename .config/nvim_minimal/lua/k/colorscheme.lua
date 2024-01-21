-- [[ colorscheme ]]

-- auto detect dark/light from OS
function dark_light_theme()
	local handle = io.popen('gsettings get org.gnome.desktop.interface color-scheme')
	local output = handle:read('*a')
	handle:close()
	output = output:gsub('\'', '')

	if string.find(output, 'dark') then
		-- vim.cmd.colorscheme 'tokyonight'
		-- vim.cmd.colorscheme 'catppuccin'
		-- vim.cmd.colorscheme 'oxocarbon'
		-- vim.cmd.colorscheme 'carbonfox'
		-- vim.cmd.colorscheme 'boo'
		-- vim.cmd.colorscheme 'colibri'
		vim.cmd.colorscheme 'default'
		vim.o.background = 'dark'

		-- vim.cmd [[hi CursorLine guibg=#252525]]
	else
		-- vim.cmd.colorscheme 'catppuccin-latte'
		-- vim.cmd.colorscheme 'colibri'
		vim.cmd.colorscheme 'default'
		vim.o.background = 'light'
	end

	-- transparent background
	vim.cmd [[ hi Normal guibg=NONE ctermbg=NONE ]]
end

dark_light_theme()
