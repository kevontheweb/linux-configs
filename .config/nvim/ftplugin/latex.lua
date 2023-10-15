-- [[ latex ]]
-- require 'lspconfig'.prosemd_lsp.setup {}
-- require 'lspconfig'.digestif.setup {}
-- require 'lspconfig'.textlsp.setup {}

vim.o.textwidth = 120
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
		vim.cmd.write()
		local cwd = vim.fn.getcwd()
		local cmd = vim.fn.jobstart({ 'make' },
			{ text = true, cwd = cwd, on_stderr = got_output, on_stdout = got_output }
		)
		if cmd then
			-- vim.fn.jobstart({ 'xdg-open', pdfname },
			-- 	{ text = true, cwd = cwd, on_stderr = got_output, on_stdout = got_output })
			vim.fn.system('xdg-open ' .. 'out.pdf')
		end
	end,
	{ desc = '[m]a[k]e pdf with pandoc' },
	{ noremap = true }
)
