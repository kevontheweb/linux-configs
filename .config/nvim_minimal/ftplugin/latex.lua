-- [[ latex ]]
-- require 'lspconfig'.prosemd_lsp.setup {}
-- require 'lspconfig'.digestif.setup {}
-- require 'lspconfig'.textlsp.setup {}

vim.cmd [[set commentstring=\%%s]]
vim.cmd [[let b:match_words = '\\(:\\)']]
vim.cmd [[let b:match_words = '\\[:\\]']]
vim.cmd [[let b:match_words = '\$:\$']]

vim.o.textwidth = 80 -- set textwidth to 80
vim.cmd[[set formatoptions-=t]] -- turn off auto line breaks
vim.o.spell = true
vim.bo.formatprg = 'prettier --stdin-filepath %'

local function got_output(channel, msg, name)
	-- vim.fn.append(vim.fn.line('$') - 1, msg) -- append to lines under cursor in buffer
	print(msg[1])
end

vim.keymap.set(
	'n',
	'<leader>mk',
	function()
		vim.cmd[[wa]]
		local cwd = vim.fn.getcwd()
		local pdfname = 'finalreport.pdf'

		-- local executable = 'zathura '
		-- local r, c = unpack(vim.api.nvim_win_get_cursor(0))
		-- local pos = r .. ':' .. c .. ':' .. vim.fn.expand('%:p') .. ' '
		-- local args = '-x \"nvim --server ' ..
		-- vim.v.servername .. ' --remote +\\%{line} \\%{input}\" --synctex-forward ' .. pos

		vim.fn.system('make clean')
		vim.fn.jobstart({ 'make' }, { text = true, cwd = cwd, on_stderr = got_output, on_stdout = got_output })
		-- vim.fn.system(executable .. ' ' .. args .. ' ' .. pdfname)
		-- vim.fn.system('zathura ' .. pdfname)
	end,
	{ desc = '[m]a[k]e pdf ' },
	{ noremap = true }
)
