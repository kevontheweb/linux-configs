-- Utilities for creating configurations
local util = require 'formatter.util'
config = {                                                 -- global so i can acces it in lua/k/keymap.lua
	lua = { require('formatter.filetypes.lua').stylua, }, -- need to use Format for this one
	python = {
		util.withl(require('formatter.filetypes.python').black), -- need to use FormatWriteLock for this one
		-- function()
		-- 	return {
		-- 		exe = 'black',
		-- 		args = {
		-- 			'-l',
		-- 			'120',
		-- 			'-t',
		-- 			'py311',
		-- 			'-pyi',
		-- 			'--',
		-- 			util.escape_path(util.get_current_buffer_file_path()),
		-- 		},
		-- 	}
		-- end
	},
	markdown = { util.withl(require('formatter.filetypes.markdown').prettierd) },
	cpp = {
		util.withl(require('formatter.filetypes.cpp').clangd),
		-- function()
		-- 	return {
		-- 		exe = "clang-format",
		-- 		args = {
		-- 			"-assume-filename",
		-- 			util.escape_path(util.get_current_buffer_file_name()),
		-- 		},
		-- 		stdin = true,
		-- 		try_node_modules = true,
		-- 	}
		-- end
	},
	['*'] = {
		require('formatter.filetypes.any').remove_trailing_whitespace,
	},
}

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require('formatter').setup {
	logging = false,
	log_level = vim.log.levels.WARN,
	filetype = config
}

-- enable the use of gq to format selections (like 'vanilla' vim)
function Formatexpr()
	local lnum = vim.v.lnum;
	local count = vim.v.count;
	require('formatter.format').format('', '', lnum, (lnum + count + 1), { lock = true })
end

vim.keymap.set('n', 'gqb', -- format entire buffer
	function()
		if config[vim.bo.filetype] == nil then
			vim.lsp.buf.format()
			vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])
			vim.o.formatexpr = 'v:lua vim.lsp.buf.format()'
		elseif vim.bo.filetype ~= 'python' then
			vim.cmd([[Format]])
			vim.cmd([[autocmd BufWritePre * Format]])
			vim.o.formatexpr = 'v:lua.Formatexpr()'
		else
			vim.cmd([[FormatLock]])
			vim.cmd([[autocmd BufWritePost * FormatLock]])
			vim.o.formatexpr = 'v:lua.Formatexpr()'
			vim.bo.modifiable = true
		end
	end,
	{ desc = '[gq]: format current [B]uffer' }
)
