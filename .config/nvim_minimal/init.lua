-- [[ my vimrc ]]
-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- these dont work
vim.cmd [[packadd gitsigns.nvim]] -- git clone https://github.com/lewis6991/gitsigns.nvim in .config/nvim/pack/gitsigns.nvim/start/
require('gitsigns').setup()

vim.cmd [[packadd Comment.nvim]] -- git clone https://github.com/numToStr/Comment.nvim in .config/nvim/pack/Comment/start/
require('Comment').setup()

vim.cmd [[packadd nvim-lspconfig]] -- git clone https://github.com/neovim/nvim-lspconfig in .config/nvim/pack/nvim-lspconfig/start/
require('k.lsp')

vim.cmd [[packadd nvim-lspconfig]] -- Collection of configurations for built-in LSP client git clone https://github.com/neovim/nvim-lspconfig in .config/nvim/pack/nvim-lspconfig/start/
vim.cmd [[packadd nvim-cmp]]       -- Autocompletion plugin git clone https://github.com/hrsh7th/nvim-cmp in .config/nvim/pack/nvim-cmp/start/
vim.cmd [[packadd cmp-nvim-lsp]]   -- LSP source for nvim-cmp git clone https://github.com/hrsh7th/cmp-nvim-lsp in .config/nvim/pack/cmp-nvim-lsp/start/
vim.cmd [[packadd cmp_luasnip]]    -- Snippets source for nvim-cmp git clone https://github.com/saadparwaiz1/cmp_luasnip in .config/nvim/pack/cmp_luasnip/start/
vim.cmd [[packadd LuaSnip]]        -- Snippets plugin git clone https://github.com/L3MON4D3/LuaSnip in .config/nvim/pack/LuaSnip/start/
vim.cmd [[packadd cmp-buffer]]     -- git clone https://github.com/hrsh7th/cmp-buffer in .config/nvim/pack/cmp-buffer/start/
vim.cmd [[packadd cmp-path]]       -- git clone https://github.com/hrsh7th/cmp-path in .config/nvim/pack/cmp-path/start/
vim.cmd [[packadd cmp-cmdline]]    -- git clone https://github.com/hrsh7th/cmp-cmdline in .config/nvim/pack/cmp-cmdline/start/
require('k.cmp')

vim.cmd [[packadd nvim-treesitter]]             -- git clone https://github.com/nvim-treesitter/nvim-treesitter in .config/nvim/pack/nvim-treesitter/start/
vim.cmd [[packadd nvim-treesitter-textobjects]] -- git clone https://github.com/nvim-treesitter/nvim-treesitter-textobjects in .config/nvim/pack/nvim-treesitter-textobjects/start/
vim.cmd [[packadd nvim-treesitter-context]]     -- git clone https://github.com/nvim-treesitter/nvim-treesitter-context in .config/nvim/pack/nvim-treesitter-context/start/
vim.cmd [[packadd nvim-treesitter-refactor]]    -- git clone https://github.com/nvim-treesitter/nvim-treesitter-refactor in .config/nvim/pack/nvim-treesitter-refactor/start/
require('k.treesitter')


vim.cmd [[packadd plenary.nvim]]    -- git clone https://github.com/nvim-lua/plenary.nvim in .config/nvim/pack/plenary/start/
vim.cmd [[packadd telescope.nvim]]    -- git clone https://github.com/nvim-telescope/telescope.nvim in .config/nvim/pack/nvim-telescope/start/
vim.cmd [[packadd telescope-fzf-native.nvim]]    -- git clone https://github.com/nvim-telescope/telescope-fzf-native.nvim in .config/nvim/pack/nvim-telescope-fzf-native/start/
vim.cmd [[packadd telescope-symbols.nvim]]    -- git clone https://github.com/nvim-telescope-symbols/telescope.nvim in .config/nvim/pack/nvim-telescope-symbols/start/
require('k.telescope')


vim.cmd [[packadd which-key.nvim]]    -- git clone https://github.com/folke/which-key.nvim in .config/nvim/pack/which-key/start/
require("which-key").setup()

require('k.configs')
require('k.statusline')
require('k.keymaps')
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
vim.o.updatetime = 80
vim.o.timeout = true
vim.o.timeoutlen = 500

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Use Netrw
vim.g.netrw_browse_split = 3
vim.g.netrw_liststyle = 3
vim.g.netrw_altv = 1 -- open vertical split on the right with 'v'
vim.g.netrw_sort_options = "i"
-- vim.g.netrw_banner = 0

vim.o.wrap = false
vim.o.linebreak = true
vim.o.textwidth = 120 -- set textwidth to 80
vim.cmd[[set formatoptions-=t]] -- turn off auto line breaks

vim.cmd [[ set listchars=tab:\┊\ ,leadmultispace:┊\ \ \ ]]
vim.cmd [[ set list ]]

-- get rid of dots after a fold
vim.g.foldmethod = 'manual'
-- vim.cmd [[ set fillchars=fold:\ ]]
-- vim.cmd [[ set foldtext=v:foldtext() ]]

-- make underscore a keywords so that you can jump through long snake case variable names
-- vim.cmd('set iskeyword-=_')

-- set max num entries for completion popup
vim.o.pumheight = 12

-- winbar (file info in the tabline even when no tabs)
-- vim.o.winbar = '%n: %f %m [%l/%L]'

vim.o.inccommand = 'nosplit'
vim.o.smoothscroll = true
vim.o.autoread = true
vim.o.showcmd = true
vim.o.cursorline = true
vim.o.laststatus = 3

-- no swap file (because it's annoying)
vim.opt.swapfile = false

vim.cmd [[ab :smile: 🙂]]
vim.cmd [[ab :cry: 😭]]
vim.cmd [[ab :shrug: 🤷]]
vim.cmd [[ab :rust: 🦀]]
vim.cmd [[ab :py: 🐍]]
vim.cmd [[ab :skull: 💀]]
vim.cmd [[ab :poop: 💩]]
vim.cmd [[ab :sparkles: ✨]]
vim.cmd [[ab ok okay]]

-- blinking cursor (this breaks in some colorschemes)
vim.cmd [[set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
		  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
		  \,sm:block-blinkwait175-blinkoff150-blinkon175]]

