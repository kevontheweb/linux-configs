-- [[ my vimrc ]]
-- Set <space> as the leader key
vim.g.mapleader = ' '

-- these dont work
vim.cmd [[packadd gitsigns.nvim]]
require('gitsigns').setup()

vim.cmd [[packadd nightfox.nvim]]

vim.cmd [[packadd Comment.nvim]]
require('Comment').setup()

vim.cmd [[packadd nvim-lspconfig]] -- git clone https://github.com/neovim/nvim-lspconfig in .config/nvim/pack/nvim-lspconfig/start/
require('k.lsp')

vim.cmd [[packadd nvim-lspconfig]] -- Collection of configurations for built-in LSP client
vim.cmd [[packadd nvim-cmp]]       -- Autocompletion plugin
vim.cmd [[packadd cmp-nvim-lsp]]   -- LSP source for nvim-cmp
vim.cmd [[packadd cmp_luasnip]]    -- Snippets source for nvim-cmp
vim.cmd [[packadd LuaSnip]]        -- Snippets plugin
vim.cmd [[packadd cmp-buffer]]
vim.cmd [[packadd cmp-path]]
vim.cmd [[packadd cmp-cmdline]]
require('k.cmp')

vim.cmd [[packadd nvim-treesitter]] -- git clone https://github.com/nvim-treesitter/nvim-treesitter in .config/nvim/pack/nvim-treesitter/start/
vim.cmd [[packadd nvim-treesitter-textobjects]]
vim.cmd [[packadd nvim-treesitter-context]]
vim.cmd [[packadd nvim-treesitter-refactor]]
require('k.treesitter')

require('k.configs')
require('k.statusline')
require('k.keymaps')

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

-- Use Netrw
vim.g.netrw_browse_split = 3
vim.g.netrw_liststyle = 3
vim.g.netrw_altv = 1 -- open vertical split on the right with 'v'
vim.g.netrw_sort_options = "i"
-- vim.g.netrw_banner = 0

vim.o.wrap = false
vim.o.linebreak = true

vim.cmd [[ set listchars=tab:\|\ ]]
vim.cmd [[ set list ]]

-- make underscore a keywords so that you can jump through long snake case variable names
-- vim.cmd('set iskeyword-=_')

-- set max num entries for completion popup
vim.o.pumheight = 12

-- winbar (file info in the tabline even when no tabs)
-- vim.o.winbar = '%n: %f %m [%l/%L]'

vim.o.smoothscroll = true
vim.o.autoread = true
vim.o.showcmd = true

vim.cmd [[set grepprg=rg\ --vimgrep]]

vim.cmd [[ab :smile: 🙂]]
vim.cmd [[ab :cry: 😭]]
vim.cmd [[ab :shrug: 🤷]]
vim.cmd [[ab :rust: 🦀]]
vim.cmd [[ab :py: 🐍]]
vim.cmd [[ab :skull: 💀]]
vim.cmd [[ab :poop: 💩]]
vim.cmd [[ab :sparkles: ✨]]

-- vim.cmd.colorscheme "habamax"
vim.cmd.colorscheme "carbonfox"
