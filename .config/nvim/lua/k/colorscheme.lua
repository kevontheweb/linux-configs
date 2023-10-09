-- [[ colorscheme ]]

-- auto detect dark/light from OS
function dark_light_theme()
	local handle = io.popen('gsettings get org.gnome.desktop.interface color-scheme')
	local output = handle:read('*a')
	handle:close()
	output = output:gsub('\'', '')

	if string.find(output, 'dark') then
		vim.o.background = "dark"
		-- vim.cmd.colorscheme 'carbonfox'
		vim.cmd.colorscheme 'tokyonight'
		-- vim.cmd [[hi CursorLine guibg=#252525]]
	else
		-- vim.o.background = "light"
		vim.o.background = "dark"
		-- vim.cmd.colorscheme 'oxocarbon'
		vim.cmd.colorscheme 'tokyonight'
		-- vim.cmd.colorscheme 'dayfox'
	end
end

dark_light_theme()
