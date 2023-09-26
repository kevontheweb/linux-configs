-- my config stuff

-- [[ vw: 'vintage wrap' ]] (only works when no splits are open)
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

-- add filetypes
vim.filetype.add({
	extension = {
		gp = "gnuplot",
		gnuplot = "gnuplot",
		cir = "spice",
		ng = "spice",
		ngspice = "spice",
	}
})

-- [[ format on save ]]
-- vim.cmd [[autocmd BufWritePost * lua vim.lsp.buf.format()]]

-- trim whitespace on save (this is done with lsps mostly)
-- vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
-- 	pattern = { '*' },
-- 	command = [[%s/\s\+$//e]],
-- })

-- [[ restore last editing location on file open ]]
vim.api.nvim_create_autocmd('BufReadPost', {
	-- group = vim.g.user.event,
	callback = function(args)
		local valid_line = vim.fn.line([['']]) >= 1 and vim.fn.line([['']]) < vim.fn.line('$')
		local not_commit = vim.b[args.buf].filetype ~= 'commit'

		if valid_line and not_commit then
			vim.cmd([[normal! g`']])
			vim.cmd([[normal! zz']])
		end
	end,
})

