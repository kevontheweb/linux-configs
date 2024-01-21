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

		{ 'lewis6991/gitsigns.nvim', },

		{ 'numToStr/Comment.nvim', },

		{
			'neovim/nvim-lspconfig',
			dependencies = {
				'williamboman/mason.nvim',
				'williamboman/mason-lspconfig.nvim',
				'mhartington/formatter.nvim',
			}
		},

		{
			'hrsh7th/nvim-cmp',
			dependencies = {
				'hrsh7th/cmp-nvim-lsp',
				'saadparwaiz1/cmp_luasnip',
				'L3MON4D3/LuaSnip',
				'rafamadriz/friendly-snippets',
				'hrsh7th/cmp-buffer',
				'hrsh7th/cmp-path',
				'hrsh7th/cmp-cmdline',
			}
		},

		{
			'nvim-treesitter/nvim-treesitter',
			dependencies = {
				'nvim-treesitter/nvim-treesitter-textobjects',
				'nvim-treesitter/nvim-treesitter-context',
				'nvim-treesitter/nvim-treesitter-refactor',
			}
		},

		{
			'nvim-telescope/telescope.nvim',
			dependencies = {
				'nvim-lua/plenary.nvim',
				-- 'nvim-telescope/telescope-fzf-native.nvim',
				'nvim-telescope-symbols/telescope.nvim',
			}
		},
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

		{ 'folke/which-key.nvim', },

		{ 'Exafunction/codeium.vim' },

		-- [[ Colorschemes ]]
		{ 'archseer/colibri.vim', },


		{ 'folke/tokyonight.nvim', },

		{ "catppuccin/nvim", },


		-- [[ AESTHETICS ]]

		{
			"utilyre/barbecue.nvim",
			dependencies = {
				"SmiteshP/nvim-navic",
				"nvim-tree/nvim-web-devicons", -- optional dependency
			},
		},


	},
	{})
