-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('plugins')
require('telescope_conf')
require('treesitter_conf')
require('lsp_conf') -- needs to be after the above keybinds
-- require('null_ls_conf') -- needs to be after lsp_conf
require('cmp_nvim_conf')
-- require('formatter_conf')

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
-- vim.cmd [[set showbreak =\ \ \ \ ]]
vim.o.showbreak = '    '

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
vim.g.netrw_browse_split = 3
vim.g.netrw_keep_dir = 0
vim.g.netrw_winsize = 30
vim.g.netrw_localcopydircmd = 'cp -r'
-- vim.g.netrw_liststyle = 3
-- vim.g.netrw_banner = 0
vim.cmd [[let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+']]

vim.o.wrap = false
vim.o.linebreak = true

-- make underscore a keywords so that you can jump through long snake case variable names
vim.cmd('set iskeyword-=_')

-- set make num entries for completion popup
vim.o.pumheight = 8

-- winbar (file info in the tabline even when no tabs)
vim.o.winbar = "%f%m [%l/%L]"

-- [[ Basic Keymaps ]]

-- don't move forward with space
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- toggle file tree
vim.keymap.set({ 'n', 'v' }, '<leader>e', '<cmd>NvimTreeToggle<CR>', { silent = true })
-- vim.keymap.set({ 'n', 'v' }, '<leader>e', '<cmd>Lexplore<CR>', { silent = true })

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
vim.keymap.set({ 'n', 't' }, '<leader>t', '<cmd>split<CR><c-w><c-j><cmd>terminal<CR>a', { noremap = true })

-- toggle focus terminal
vim.keymap.set({ 'n', 't' }, '<c-t>', '<c-\\><c-n>', { noremap = true })

-- <c-s> saves in insert mode
vim.keymap.set({ 'i' }, '<c-s>', '<cmd>w<CR>a', { noremap = true })

-- <meta-z> toggle wrapping (like in vscode)
vim.keymap.set({ 'i' }, '<meta-z>', '<cmd>set wrap!<cr><cmd>lua vim.opt_local.columns=80<CR>i', { noremap = true })
vim.keymap.set({ 'n' }, '<meta-z>', '<cmd>set wrap!<CR><cmd>lua vim.opt_local.columns=80<CR>', { noremap = true })

-- vw: "vintage wrap"
--[[ vim.keymap.set({ 'n' }, '<leader>vw',
	function()
		vim.api.update_option('wrap', not vim.wo.wrap)
		vim.api.update_option('columns', vim.o.columns)
	end,
	{ noremap = true })
 ]]

-- Remap for dealing with word wrap (I don't like this)
-- vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

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
-- keybind format
vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "[C]ode action: [F]ormat current buffer" })

-- compiler stuffs
vim.cmd [[autocmd BufRead * lua vim.keymap.set('n', '<leader>cr', '<cmd>!../../compile.sh %<cr>', { desc = "Compile and open markdown document" }) ]]


-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

vim.keymap.set('n', '{', '{zz')
vim.keymap.set('n', '}', '}zz')

-- open file_browser with the path of the current buffer
vim.keymap.set(
	"n",
	"<space>fb",
	require "telescope".extensions.file_browser.file_browser,
	{ noremap = true },
	{ desc = "Telescope [f]ile [b]rowser" }
)

-- restore last editing location on file open
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
