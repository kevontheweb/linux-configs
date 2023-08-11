-- [[ my vimrc ]]
-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ imports ]]
require('plugins')
require('k.telescope')
require('k.treesitter')
require('k.lsp') -- needs to be after the above keybinds
require('k.cmp_nvim')
require('k.formatter')
require('k.configs')
require('k.keymap')
require('k.treesitter_textobjects')

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
vim.o.showbreak = '  ↳ '

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
vim.g.netrw_liststyle = 3
vim.g.netrw_altv = 1 -- open vertical split on the right with 'v'

vim.o.wrap = false
vim.o.linebreak = true

-- make underscore a keywords so that you can jump through long snake case variable names
-- vim.cmd('set iskeyword-=_')

-- set max num entries for completion popup
vim.o.pumheight = 12

-- winbar (file info in the tabline even when no tabs)
vim.o.winbar = "(%f %m) (%l/%L) (%n)"
