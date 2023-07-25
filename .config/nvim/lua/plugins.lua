-- Install package manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	}
end
vim.opt.rtp:prepend(lazypath)

-- setup package manager
require('lazy').setup({
		{
			-- LSP Configuration & Plugins
			'neovim/nvim-lspconfig',
			dependencies = {
				-- Automatically install LSPs to stdpath for neovim
				'williamboman/mason.nvim',
				'williamboman/mason-lspconfig.nvim',
			},
		},

		{
			-- Autocompletion
			'hrsh7th/nvim-cmp',
			dependencies = {
				'hrsh7th/cmp-nvim-lsp',
				'L3MON4D3/LuaSnip',
				'saadparwaiz1/cmp_luasnip',
				'hrsh7th/cmp-buffer',
				'hrsh7th/cmp-path',
				'hrsh7th/cmp-cmdline',
				'f3fora/cmp-spell'
			},
		},
		-- formatting
		{
			"jay-babu/mason-null-ls.nvim",
			event = { "BufReadPre", "BufNewFile" },
			dependencies = {
				"williamboman/mason.nvim",
				"jose-elias-alvarez/null-ls.nvim",
			},
			config = function()
				-- require("your.null-ls.config") -- require your null-ls config here (example below)
				local null_ls = require("null-ls")
				null_ls.setup({
					sources = {
						null_ls.builtins.formatting.black,
						null_ls.builtins.formatting.clang_format,
						null_ls.builtins.formatting.prettierd,
					},
				})
			end,
			lazy = true
		},

		{
			'mhartington/formatter.nvim',
			lazy = true
		},

		-- AI
		{ 'Exafunction/codeium.vim' },

		-- Useful plugin to show you pending keybinds.
		{
			'folke/which-key.nvim',
			opts = {}
		},

		{
			-- Adds git releated signs to the gutter, as well as utilities for managing changes
			'lewis6991/gitsigns.nvim',
			opts = {
				-- See `:help gitsigns.txt`
				signs = {
					add = { text = '+' },
					change = { text = '~' },
					delete = { text = '_' },
					topdelete = { text = '‾' },
					changedelete = { text = '~' },
				},
			},
		},

		{
			"folke/zen-mode.nvim",
			dependencies = {
				'folke/twilight.nvim'
			},
			opts = {
				window = {
					width = 120,
				},
				plugins = {
					wezterm = {
						enabled = true,
						-- can be either an absolute font size or the number of incremental steps
						font = "+0", -- (10% increase per step)
					},
					twilight = {
						enabled = false,
					},
					gitsigns = {
						enabled = true,
					}
				},
				-- callback where you can add custom code when the Zen window opens
				on_open = function(win)
					vim.o.number = false
				end,
				-- callback where you can add custom code when the Zen window closes
				on_close = function()
					vim.o.number = true
				end,
			},
		},

		{
			-- Theme inspired by Atom
			'navarasu/onedark.nvim',
			priority = 1000,
			config = function()
				vim.cmd.colorscheme 'onedark'
			end,
			lazy = true
		},


		{
			'folke/tokyonight.nvim',
			config = function()
				require("tokyonight").setup({
					style = "night",
					light_style = "day",
					transparent = true,
					terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
					styles = {
						comments = { italic = true },
						keywords = { italic = true },
						functions = {},
						variables = {},
						sidebars = "dark",
						floats = "dark",
					},
					hide_inactive_statusline = true, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
					dim_inactive = true, -- dims inactive windows
				})
				vim.cmd.colorscheme 'tokyonight'
			end,
			lazy = false
		},

		{
			'Mofiqul/dracula.nvim',
			config = function()
				require("dracula").setup()
			end,
			lazy = true
		},

		{
			'nvim-tree/nvim-tree.lua',
			dependencies = { 'nvim-tree/nvim-web-devicons' },
			config = function()
				require("nvim-tree").setup({
					disable_netrw = false,
					hijack_netrw = true,
					sync_root_with_cwd = false,
					view = {
						cursorline = true,
						adaptive_size = true,
						hide_root_folder = false,
						side = "left",
						preserve_window_proportions = true,
						signcolumn = "yes",
					},
					diagnostics = {
						enable = true,
						show_on_dirs = false,
					},
					trash = {
						cmd = "trash",
						require_confirm = true,
					},
				})
			end,
			lazy = true,
		},

		{
			"nvim-telescope/telescope-file-browser.nvim",
			dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }

		},

		{
			-- Set lualine as statusline
			'nvim-lualine/lualine.nvim',
			-- See `:help lualine.txt`
			opts = {
				options = {
					icons_enabled = true,
					theme = 'tokyonight',
					component_separators = '|',
					section_separators = '',
				},
			},
			-- lazy = true,
		},

		{
			-- Add indentation guides even on blank lines
			'lukas-reineke/indent-blankline.nvim',
			-- Enable `lukas-reineke/indent-blankline.nvim`
			-- See `:help indent_blankline.txt`
			opts = {
				char = '┊',
				show_trailing_blankline_indent = false,
			},
		},

		-- "gc" to comment visual regions/lines
		{ 'numToStr/Comment.nvim',         opts = {} },

		-- Fuzzy Finder (files, lsp, etc)
		{ 'nvim-telescope/telescope.nvim', version = '*', dependencies = { 'nvim-lua/plenary.nvim' } },

		-- Fuzzy Finder Algorithm which requires local dependencies to be built.
		-- Only load if `make` is available. Make sure you have the system
		-- requirements installed.
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			-- NOTE: If you are having trouble with this installation,
			--       refer to the README for telescope-fzf-native for more instructions.
			build = 'make',
			cond = function()
				return vim.fn.executable 'make' == 1
			end,
		},

		{
			-- Highlight, edit, and navigate code
			'nvim-treesitter/nvim-treesitter',
			config = function()
				pcall(require('nvim-treesitter.install').update { with_sync = true })
			end,
		},

	},
	{})
