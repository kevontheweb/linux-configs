require'lspconfig'.clangd.setup{}

-- run python
vim.keymap.set(
	'n',
	'<leader>mk',
	function()
		vim.cmd.write()
		local cwd = vim.fn.getcwd()
		local buff = vim.api.nvim_get_current_buf()
		local filename = vim.api.nvim_buf_get_name(buff)
		vim.fn.jobstart({ './plot.sh', 'pdf', 'xkcd' }, { text = true, cwd = cwd })
	end,
	{ desc = '[M]a[k]e' },
	{ noremap = true }
)

vim.o.tabstop = 2
vim.cmd [[ set listchars=tab:\┊\ ,leadmultispace:┊\ ]]
