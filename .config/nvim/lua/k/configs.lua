-- my config stuff

-- [[ restore last editing location on file open ]]
-- From vim defaults.vim
-- ---
-- When editing a file, always jump to the last known cursor position.
-- Don't do it when the position is invalid, when inside an event handler
-- (happens when dropping a file on gvim) and for a commit message (it's
-- likely a different one than last time).
vim.api.nvim_create_autocmd('BufReadPost', {
	-- group = vim.g.user.event,
	callback = function(args)
		local valid_line = vim.fn.line([['"]]) >= 1 and vim.fn.line([['"]]) < vim.fn.line('$')
		local not_commit = vim.b[args.buf].filetype ~= 'commit'

		if valid_line and not_commit then
			vim.cmd([[normal! g`"]])
			vim.cmd([[normal! zz"]])
		end
	end,
})

-- vw: "vintage wrap"

vim.keymap.set({ 'n' }, '<leader>vw',
	function()
		vim.wo.wrap = not vim.wo.wrap
		if vim.o.columns > 80 then
			cols = vim.o.columns
			vim.o.columns = 80
		elseif vim.o.columns <= 80 then
			vim.o.columns = cols
		end
	end,
	{ noremap = true }
)


-- [[ Highlight on yank ]]
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = '*',
})

-- [[ format on save ]]
vim.cmd [[autocmd BufWritePre *80 lua vim.lsp.buf.format()]]

-- compiler stuffs
vim.cmd [[autocmd BufRead * lua vim.keymap.set('n', '<leader>cr', '<cmd>!../../compile.sh %<cr>', { desc = "Compile and open markdown document" }) ]]
