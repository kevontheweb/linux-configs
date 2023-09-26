local function fuzz()
	vim.ui.input({ prompt = 'vimgrep: ' }, function(input)
		local query = input
		vim.cmd [[call setqflist([])]] -- clear qflist
		vim.cmd.vimgrep('/', query, '/f **')
		vim.cmd.copen()
	end)
end
vim.keymap.set('n', '<leader>ff', fuzz, { noremap = true })

