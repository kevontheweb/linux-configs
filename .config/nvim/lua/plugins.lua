-- [[ Plugin manager ]]
-- Install package manager (Lazy)
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
		-- [[ LSP ]]
		{
			-- LSP Configuration & Plugins
			'neovim/nvim-lspconfig',
			dependencies = {
				-- Automatically install LSPs to stdpath for neovim
				-- 'williamboman/mason.nvim',
				-- 'williamboman/mason-lspconfig.nvim',
			},
			lazy = true,
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
			lazy = true,
		},

		{
			'L3MON4D3/LuaSnip',
			dependencies = { 'rafamadriz/friendly-snippets' },
			config = function()
				require('luasnip.loaders.from_vscode').lazy_load()
			end,
			lazy = true,
		},


		{
			'nvim-orgmode/orgmode',
			lazy = true,
			event = "VeryLazy",
			config = function()
				require('orgmode').setup_ts_grammar()
				require('orgmode').setup {}
			end
		},

		-- [[ AI ]]
		{
			'Exafunction/codeium.vim',
			config = function()
				-- Change '<C-g>' here to any keycode you like.
				vim.keymap.set('i', '<Tab>', function() return vim.fn['codeium#Accept']() end,
					{ expr = true })
				vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end,
					{ expr = true })
				vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end,
					{ expr = true })
				vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end,
					{ expr = true })
			end,
			lazy = true,
			event = "VeryLazy",
		},


		-- [[ GIT ]]
		{
			-- Adds git releated signs to the gutter, as well as utilities for managing changes
			'lewis6991/gitsigns.nvim',
			lazy = true,
			event = 'BufRead',
			config = function()
				require('gitsigns').setup {
					signs = {
						add          = { text = '+' },
						change       = { text = '>' },
						delete       = { text = '-' },
						topdelete    = { text = '-' },
						changedelete = { text = '~' },
						untracked    = { text = '┆' },
					},
					-- sign_priority = 100
				}
			end
		},

		-- [[ NICETIES ]]
		-- show pending keybinds
		{
			'folke/which-key.nvim',
			init = function()
				vim.o.timeout = true
				vim.o.timeoutlen = 250
			end,
			opts = {
				window = {
					border = "rounded", },
				disable = {
					buftypes = {},
					filetypes = {},
				},
			},
			lazy = true,
			event = "VeryLazy",
		},

		-- 'gc' to comment visual regions/lines
		{
			'numToStr/Comment.nvim',
			opts = {},
			lazy = true,
			event = "BufReadPost",
		},


		-- [[ Colorschemes ]]
		{ 'archseer/colibri.vim' },

		{
			'rockerBOO/boo-colorscheme-nvim',
			-- lazy = true,
			config = function()
				if vim.fn.has("termguicolors") then
					vim.opt.termguicolors = true
				end
				require("boo-colorscheme").use({
					italic = true, -- toggle italics
					theme = "boo"
				})
			end
		},

		{
			"EdenEast/nightfox.nvim",
			lazy = true,
			config = function()
				require('nightfox').setup({
					options = {
						transparent = true,
						styles = {
							comments = "italic", -- Value is any valid attr-list value `:help attr-list`
							conditionals = "NONE",
							constants = "bold",
							functions = "italic",
							keywords = "NONE",
							numbers = "bold",
							operators = "NONE",
							strings = "NONE",
							types = "NONE",
							variables = "NONE",
						},
					}
				})
			end
		},

		{
			"nyoom-engineering/oxocarbon.nvim",
			lazy = true,
			config = function()
				require('nightfox').setup({
					options = {
						transparent = true,
					}
				})
			end,
		},

		{
			'rebelot/kanagawa.nvim',
			config = function()
				-- Default options:
				require('kanagawa').setup({
					undercurl = false, -- enable undercurls
					transparent = true, -- do not set background color
					theme = "dragon", -- Load "wave" theme when 'background' option is not set
					background = { -- map the value of 'background' option to a theme
						dark = "wave", -- try "dragon" !
						light = "lotus"
					},
					colors = {
						theme = {
							all = {
								ui = {
									bg_gutter = "none",
									float = { bg = "none" }
								}
							},
						},
					},
				})

				-- setup must be called before loading
				-- vim.cmd("colorscheme kanagawa")
			end,
			lazy = true
		},

		{
			"bluz71/vim-nightfly-colors",
			name = "nightfly",
			lazy = true,
			priority = 1000
		},

		{
			"bluz71/vim-moonfly-colors",
			name = "moonfly",
			lazy = true,
			priority = 1000
		},

		{
			'folke/tokyonight.nvim',
			config = function()
				require('tokyonight').setup({
					style = 'night',
					light_style = 'day',
					transparent = true,
					terminal_colors = false, -- Configure the colors used when opening a `:terminal` in Neovim
					styles = {
						comments = { italic = true },
						keywords = { italic = false },
						functions = { italic = true },
						variables = {},
						sidebars = 'dark',
						floats = 'dark',
					},
					hide_inactive_statusline = true,
					dim_inactive = true, -- dims inactive windows
					on_highlights = function(hl, colors)
						hl.DiagnosticUnderlineError.undercurl = false
						hl.DiagnosticUnderlineError.underline = true
						hl.DiagnosticUnderlineWarn.undercurl = false
						hl.DiagnosticUnderlineWarn.underline = true
						hl.DiagnosticUnderlineInfo.undercurl = false
						hl.DiagnosticUnderlineInfo.underline = true
						hl.DiagnosticUnderlineHint.undercurl = false
						hl.DiagnosticUnderlineHint.underline = true
						hl.DiagnosticVirtualTextError.bg = colors.none
						hl.DiagnosticVirtualTextWarn.bg = colors.none
						hl.DiagnosticVirtualTextInfo.bg = colors.none
						hl.DiagnosticVirtualTextHint.bg = colors.none
					end,
					on_colors = function(colors)
						colors.border = colors.fg_dark
					end

				})
			end,
			lazy = true
		},

		{
			"catppuccin/nvim",
			name = "catppuccin",
			priority = 1000,
			config = function()
				require("catppuccin").setup({
					transparent_background = true
				})
				-- vim.cmd.colorscheme "catppuccin-mocha"
			end,
			lazy = true
		},


		-- [[ AESTHETICS ]]
		--
		{
			"utilyre/barbecue.nvim",
			dependencies = {
				"SmiteshP/nvim-navic",
				"nvim-tree/nvim-web-devicons", -- optional dependency
			},
			opts = {
				-- configurations go here
				-- kinds = false
			},
			lazy = true,
			event = "BufReadPost",
		},

		--  [[ telescope ]]
		{
			'nvim-telescope/telescope.nvim',
			version = '*',
			dependencies = { 'nvim-lua/plenary.nvim' },
			lazy = true,
			event = "VeryLazy"

		},

		{
			'nvim-telescope/telescope-fzf-native.nvim',
			build = 'make',
			cond = function()
				return vim.fn.executable 'make' == 1
			end,
			dependencies = { 'nvim-telescope/telescope.nvim' },
			lazy = true,
			event = "VeryLazy"

		},

		{
			'nvim-telescope/telescope-symbols.nvim',
			dependencies = { 'nvim-telescope/telescope.nvim' },
			lazy = true,
			event = "VeryLazy"

		},

		{
			'nvim-telescope/telescope-bibtex.nvim',
			dependencies = { 'nvim-telescope/telescope.nvim' },
			lazy = true,
			event = "VeryLazy"

		},

		-- [[ tree sitter ]]
		{
			'nvim-treesitter/nvim-treesitter',
			config = function()
				pcall(require('nvim-treesitter.install').update { with_sync = true })
			end,
			lazy = true,
		},
		{
			'nvim-treesitter/nvim-treesitter-textobjects',
			dependencies = 'nvim-treesitter',
			lazy = true,
		},
		{
			'nvim-treesitter/nvim-treesitter-refactor',
			dependencies = 'nvim-treesitter',
			lazy = true,
		},
		{
			'nvim-treesitter/nvim-treesitter-context',
			dependencies = 'nvim-treesitter',
			lazy = true,
		}, -- using barbecue
	},
	{})
