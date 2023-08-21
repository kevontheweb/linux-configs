-- run python
vim.keymap.set(
	'n',
	'<leader>mk',
	function()
		vim.cmd.write()
		local cwd = vim.fn.getcwd()
		local buff = vim.api.nvim_get_current_buf()
		local filename = vim.api.nvim_buf_get_name(buff)
		-- vim._system({ 'python3', filename }, { text = true, cwd = cwd }, on_exit)
		--{'on_stdout':{j,d,e->append(line('.'),d)}}
		vim.fn.jobstart({ './plot.sh', 'pdf', 'xkcd' }, { text = true, cwd = cwd })
	end,
	{ desc = '[M]a[k]e' },
	{ noremap = true }
)
