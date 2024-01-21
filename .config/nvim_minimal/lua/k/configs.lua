-- [[ Configs ]]
-- my custom config stuff that isn't just a setting

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
		tex = "latex",
	}
})


local remember_folds = vim.api.nvim_create_augroup("RememberFolds", { clear = true })
vim.api.nvim_create_autocmd("BufWinLeave", {
	group = remember_folds,
	desc = "Remember folds and window stuff",
	pattern = "*",
	callback = function() vim.cmd[[silent! mkview]] end,
})
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = remember_folds,
	desc = "Remember folds and window stuff",
	pattern = "*",
	callback = function() vim.cmd[[silent! loadview]] end,
})

-- [[ format on save ]]
-- vim.cmd [[autocmd BufWritePost * lua vim.lsp.buf.format()]]
-- trim whitespace on save (this is done with lsps mostly)
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
	pattern = { '*' },
	command = [[%s/\s\+$//e]],
})
