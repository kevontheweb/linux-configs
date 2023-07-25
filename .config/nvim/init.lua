-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('plugins')
require('telescope_conf')
require('treesitter_conf')
require('lsp_conf')     -- needs to be after the above keybinds
require('null_ls_conf') -- needs to be after lsp_conf
require('cmp_nvim_conf')

-- [[ Setting options ]]

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
vim.o.clipboard = 'unnamedplus'

-- make tab = 4 spaces
vim.o.tabstop = 4

-- indent wrapped lines by 4 spaces
vim.cmd [[set showbreak =\ \ \ \ ]]

-- Enable break indent
vim.o.breakindent = false

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Use Netrw
-- vim.cmd('let g:netrw_liststyle=3')
-- vim.cmd('let g:netrw_banner=0')
-- vim.cmd('let g:netrw_browse_split=3')
-- vim.g.netrw_liststyle = 3

vim.o.wrap = false
vim.o.linebreak = true

-- make underscore a keywords so that you can jump through long snake case variable names
vim.cmd('set iskeyword-=_')

-- set make num entries for completion popup
vim.o.pumheight = 8

-- [[ Basic Keymaps ]]

-- don't move forward with space
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- toggle file tree
vim.keymap.set({ 'n', 'v' }, '<leader>t', ':NvimTreeToggle<CR>', { silent = true })
-- vim.keymap.set({ 'n', 'v' }, '<leader>t', ':Vexplore<CR>', { silent = true })

-- close file tree if it's the last window ()
--[[
vim.api.nvim_create_autocmd("BufEnter", {
	nested = true,
	callback = function()
		if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
			vim.cmd "quit"
		end
	end
})
]]

-- centre cursor in midlle of screen
vim.keymap.set({ 'n' }, '<leader>z', 'zzzszH', { noremap = true })

-- open terminal
vim.keymap.set({ 'n', 't' }, '<leader>tt', ':split<CR><c-w><c-j>:terminal<CR>a', { noremap = true })

-- toggle focus terminal
vim.keymap.set({ 'n', 't' }, '<c-t>', '<c-\\><c-n>', { noremap = true })

-- <c-s> saves in insert mode
vim.keymap.set({ 'i' }, '<c-s>', ':w<CR>', { noremap = true })

-- Remap for dealing with word wrap (I don't like this)
-- vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

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
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

-- compiler stuffs
vim.cmd [[autocmd BufRead * lua vim.keymap.set('n', '<leader>cr', ':!../../compile.sh %<cr>', { desc = "Compile and open markdown document" }) ]]


-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- restore last editing location on file open
--[[ vim.api.nvim_create_autocmd({ "BufReadPost" }, {
	pattern = { "*" },
	callback = function()
		vim.api.nvim_exec('silent! normal! g`"zz', false)
	end,
}) ]]
