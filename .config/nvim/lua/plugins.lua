vim.cmd [[packadd packer.nvim]]

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
    use 'wbthomason/packer.nvim'
    -- colorscheme
    use {"catppuccin/nvim", as = "catppuccin"}
    -- better syntax highlighting
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({
                with_sync = true
            })
            ts_update()
        end
    }
    -- lsp stuff
    if vim.g.vscode then
        print('not loading some plugins for vscode')
    else
        use {'neovim/nvim-lspconfig'}
        use {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig",
            requires = {"neovim/nvim-lspconfig"}
        }
        use {'hrsh7th/nvim-cmp'}
        use {'hrsh7th/cmp-buffer'}
        use {'hrsh7th/cmp-path'}
        use {'hrsh7th/cmp-nvim-lua'}
        use {'hrsh7th/cmp-nvim-lsp'}
        use {'hrsh7th/cmp-cmdline'}
        -- code formatters
        use({
            "jose-elias-alvarez/null-ls.nvim",
            config = function() require("null-ls").setup() end,
            requires = {"nvim-lua/plenary.nvim", 'MunifTanjim/prettier.nvim'}
        })

    end
    -- comment shortcuts
    use {
        'numToStr/Comment.nvim',
        config = function() require('Comment').setup() end
    }
    -- file picker
    use {'nvim-tree/nvim-tree.lua'}
    if packer_bootstrap then require('packer').sync() end
end)
