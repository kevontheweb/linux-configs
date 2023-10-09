-- [[ c++ ]]
require'lspconfig'.clangd.setup{}

vim.o.tabstop = 2

vim.cmd [[ set listchars=tab:\┊\ ,leadmultispace:┊\ ]]

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

-- trim whitespace on save (clangd doesn't do this)
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
	pattern = { '*' },
	command = [[%s/\s\+$//e]],
})
