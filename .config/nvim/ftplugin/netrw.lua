-- [[  netrw ]]
vim.keymap.set('n', 'g?', '<cmd>:help netrw-quickmap<CR>')
vim.keymap.set('n', 'q',
	function()
		local file_type = vim.bo.filetype
		if file_type == 'netrw' then
			vim.cmd.close()
		end
	end,
	{ buffer = true, silent = true },
	{ desc = '[Q]uit netrw' }

)
