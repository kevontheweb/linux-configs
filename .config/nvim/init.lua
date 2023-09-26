-- [[ my vimrc ]]
-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ imports ]]
require('plugins')
require('k.plugins.telescope')
require('k.plugins.treesitter')
require('k.plugins.lsp') -- needs to be after the above keybinds
require('k.plugins.cmp_nvim')
-- require('k.plugins.lualine')
require('k.configs')
require('k.keymaps')
require('k.statusline')
require('k.colorscheme')

-- [[ Setting options ]]
-- Set highlight on search
vim.o.hlsearch = true

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
-- vim.o.termguicolors = true

-- Use Netrw
vim.g.netrw_browse_split = 3
vim.g.netrw_liststyle = 3
vim.g.netrw_altv = 1 -- open vertical split on the right with 'v'
vim.g.netrw_sort_options = "i"
-- vim.g.netrw_banner = 0

vim.o.wrap = false
vim.o.linebreak = true

vim.cmd [[ set listchars=tab:\┊\ ,leadmultispace:┊\ \ \ ]]
vim.cmd [[ set list ]]

-- get rid of dots after a fold
vim.cmd [[ set fillchars=fold:\ ]]
-- vim.cmd [[ set foldtext=v:foldtext() ]]

-- make underscore a keywords so that you can jump through long snake case variable names
-- vim.cmd('set iskeyword-=_')

-- set max num entries for completion popup
vim.o.pumheight = 12

-- winbar (file info in the tabline even when no tabs)
-- vim.o.winbar = '%n: %f %m [%l/%L]'

vim.o.smoothscroll = true
vim.o.autoread = true
vim.o.showcmd = true
vim.o.cursorline = true
vim.o.laststatus = 3

vim.cmd [[ab :smile: 🙂]]
vim.cmd [[ab :cry: 😭]]
vim.cmd [[ab :shrug: 🤷]]
vim.cmd [[ab :rust: 🦀]]
vim.cmd [[ab :py: 🐍]]
vim.cmd [[ab :skull: 💀]]
vim.cmd [[ab :poop: 💩]]
vim.cmd [[ab :sparkles: ✨]]
vim.cmd [[ab :ok: 👌]]

-- blinking cursor (this breaks in some colorschemes)
vim.cmd [[set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
		  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
		  \,sm:block-blinkwait175-blinkoff150-blinkon175]]
