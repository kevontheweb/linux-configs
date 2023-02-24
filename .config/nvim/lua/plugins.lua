local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') ..
                             '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({
            'git', 'clone', '--depth', '1',
            'https://github.com/wbthomason/packer.nvim', install_path
        })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    if vim.g.vscode then
        print('not loading plugins')
    else
        use({'wbthomason/packer.nvim'})
        -- colorscheme
        use({
            'catppuccin/nvim',
            as = 'catppuccin',
            branch = 'main',
            run = ':CatppuccinCompile'
        })

        use({'olimorris/onedarkpro.nvim'})
        use({'projekt0n/github-nvim-theme', tag = 'v0.0.7'})

        -- better syntax highlighting
        use({
            'nvim-treesitter/nvim-treesitter',
            run = function()
                local ts_update = require('nvim-treesitter.install').update({
                    with_sync = true
                })
                ts_update()
            end,
            config = function() require('config.treesitter_config') end
        })

        -- lsp
        use({'neovim/nvim-lspconfig'})

        use({
            'hrsh7th/nvim-cmp',
            event = 'BufRead',
            requires = {
                -- vscode pictograms
                {'onsails/lspkind.nvim'}, -- nvim-cmp
                -- { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
                {'hrsh7th/cmp-buffer', after = 'nvim-cmp'},
                {'hrsh7th/cmp-path', after = 'nvim-cmp'},
                {'f3fora/cmp-spell', after = 'nvim-cmp'},
                {'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp'},
                {'hrsh7th/cmp-cmdline', after = 'nvim-cmp'},
                {'hrsh7th/cmp-calc', after = 'nvim-cmp'},
                {'hrsh7th/cmp-emoji', after = 'nvim-cmp'}
            },
            config = function() require('config.cmp_config') end
        })

        use({
            'williamboman/mason.nvim',
            event = 'BufRead',
            requires = {{'neovim/nvim-lspconfig'}, {'hrsh7th/cmp-nvim-lsp'}},
            -- config = function() require('mason').setup() end
            config = function() require('config.mason_config') end
        })

        use({
            'williamboman/mason-lspconfig.nvim',
            requires = {'williamboman/mason.nvim'}
        })

        -- code formatters
        use({
            'jose-elias-alvarez/null-ls.nvim',
            requires = {
                {'nvim-lua/plenary.nvim'}, {'MunifTanjim/prettier.nvim'}
            },
            config = function() require('config.null_ls_config') end
        })

        -- comment shortcuts
        use({
            'numToStr/Comment.nvim',
            config = function() require('Comment').setup() end
        })

        -- file picker
        use({
            'nvim-tree/nvim-tree.lua',
            requires = {
                'nvim-tree/nvim-web-devicons' -- optional, for file icons
            },
            config = function() require('config.nvim_tree_config') end
        })
    end
    if packer_bootstrap then require('packer').sync() end
end)
