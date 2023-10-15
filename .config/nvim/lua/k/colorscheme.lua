-- [[ colorscheme ]]

-- auto detect dark/light from OS
function dark_light_theme()
	local handle = io.popen('gsettings get org.gnome.desktop.interface color-scheme')
	local output = handle:read('*a')
	handle:close()
	output = output:gsub('\'', '')

	if string.find(output, 'dark') then
		vim.o.background = "dark"
		-- vim.cmd.colorscheme 'tokyonight'

		vim.cmd.colorscheme 'kanagawa'
		vim.cmd [[hi Cursor guibg=#938AA9]]

		-- vim.cmd.colorscheme 'colibri'

		-- vim.cmd.colorscheme 'boo'

		-- vim.cmd.colorscheme 'carbonfox'
		-- vim.cmd [[hi CursorLine guibg=#252525]]
	else
		vim.o.background = "light"
		vim.cmd.colorscheme 'catppuccin-latte'
	end
end

dark_light_theme()
