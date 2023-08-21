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
		-- [[ LSP ]]
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

		{

			'L3MON4D3/LuaSnip',
			dependencies = { 'rafamadriz/friendly-snippets' },
			config = function()
				require('luasnip.loaders.from_vscode').lazy_load()
			end
		},


		-- [[ AI ]]
		{
			'Exafunction/codeium.vim',
			event = "BufEnter",
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
			end
		},


		-- [[ GIT ]]
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

		-- [[ NICETIES ]]
		-- show pending keybinds
		{
			'folke/which-key.nvim',
			event = "VeryLazy",
			init = function()
				vim.o.timeout = true
				vim.o.timeoutlen = 250
			end,
			opts = {
				window = {
					border = "single", },
				disable = {
					buftypes = {},
					filetypes = {},
				},
			}
		},

		-- 'gc' to comment visual regions/lines
		{
			'numToStr/Comment.nvim',
			opts = {}
		},


		--[[ {
			'folke/trouble.nvim',
			dependencies = { 'nvim-tree/nvim-web-devicons' },
			opts = {},
		}, ]]

		-- [[ Colorschemes ]]

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
				require('tokyonight').setup({
					style = 'night',
					light_style = 'day',
					transparent = true,
					terminal_colors = false, -- Configure the colors used when opening a `:terminal` in Neovim
					styles = {
						comments = { italic = true },
						keywords = { italic = true },
						functions = {},
						variables = {},
						sidebars = 'dark',
						floats = 'dark',
					},
					hide_inactive_statusline = true, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
					dim_inactive = true, -- dims inactive windows
				})
				vim.cmd.colorscheme 'tokyonight'
			end,
			lazy = false
		},

		{
			"catppuccin/nvim",
			name = "catppuccin",
			priority = 1000,
			config = function()
				require("catppuccin").setup({
					transparent_background = true
				})
				vim.cmd.colorscheme "catppuccin-mocha"
			end,
			lazy = true
		},

		{
			'sainnhe/everforest',
			config = function()
				vim.g.everforest_enable_italic = 1
				vim.g.everforest_transparent_background = 1
				vim.g.everforest_better_performance = 1
				vim.cmd.colorscheme 'everforest'
			end,
			lazy = true
		},



		-- [[ AESTHETICS ]]
		{
			'folke/zen-mode.nvim',
			dependencies = {
				'folke/twilight.nvim'
			},
			event = "VeryLazy",
			opts = {
				window = {
					width = 120,
				},
				plugins = {
					wezterm = {
						enabled = true,
						-- can be either an absolute font size or the number of incremental steps
						font = '+0', -- (10% increase per step)
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

		-- discord integration
		{
			'andweeb/presence.nvim',
			config = function()
				require('presence').setup()
			end
		},

		{
			-- Set lualine as statusline
			'nvim-lualine/lualine.nvim',
			-- See `:help lualine.txt`
			after = 'folke/tokyonight.nvim',
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

		--  [[ telescope ]]
		{
			'nvim-telescope/telescope.nvim',
			version = '*',
			dependencies = { 'nvim-lua/plenary.nvim' }
		},

		{
			'nvim-telescope/telescope-file-browser.nvim',
			dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' }

		},

		{
			'nvim-telescope/telescope-fzf-native.nvim',
			-- NOTE: If you are having trouble with this installation,
			--       refer to the README for telescope-fzf-native for more instructions.
			build = 'make',
			cond = function()
				return vim.fn.executable 'make' == 1
			end,
		},

		{ 'nvim-telescope/telescope-symbols.nvim' },

		{
			'nvim-telescope/telescope-bibtex.nvim',
			confilg = function()
				require "telescope".load_extension("bibtex")
			end,
		},

		-- [[ tree sitter ]]
		{
			-- Highlight, edit, and navigate code
			'nvim-treesitter/nvim-treesitter',
			config = function()
				pcall(require('nvim-treesitter.install').update { with_sync = true })
			end,
		},
		{ 'nvim-treesitter/playground',                  after = 'nvim-treesitter' },
		{ 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' },
		{ 'nvim-treesitter/nvim-treesitter-refactor',    after = 'nvim-treesitter' },
		{ 'nvim-treesitter/nvim-treesitter-context',    after = 'nvim-treesitter' },


		{
			'glacambre/firenvim',

			-- Lazy load firenvim
			-- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
			lazy = not vim.g.started_by_firenvim,
			build = function()
				vim.fn["firenvim#install"](0)
			end,
			config = function()
				vim.api.nvim_create_autocmd({ 'UIEnter' }, {
					callback = function(event)
						local client = vim.api.nvim_get_chan_info(vim.v.event.chan).client
						if client ~= nil and client.name == "Firenvim" then
							vim.o.laststatus = 0
							vim.o.winbar = ''
						end
					end
				})
			end
		}
	},
	{})
