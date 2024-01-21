#!/bin/sh
mkdir -p ~/.config/nvim/pack/gitsigns.nvim/start/ && cd  ~/.config/nvim/pack/gitsigns.nvim/start/ && git clone https://github.com/lewis6991/gitsigns.nvim

mkdir -p ~/.config/nvim/pack/Comment/start/ && cd  ~/.config/nvim/pack/Comment/start/ && git clone https://github.com/numToStr/Comment.nvim

mkdir -p ~/.config/nvim/pack/nvim-lspconfig/start/ && cd  ~/.config/nvim/pack/nvim-lspconfig/start/ && git clone https://github.com/neovim/nvim-lspconfig/

mkdir -p ~/.config/nvim/pack/nvim-cmp/start/ && cd  ~/.config/nvim/pack/nvim-cmp/start/ && git clone https://github.com/hrsh7th/nvim-cmp
mkdir -p ~/.config/nvim/pack/cmp-nvim-lsp/start/ && cd  ~/.config/nvim/pack/cmp-nvim-lsp/start/ && git clone https://github.com/hrsh7th/cmp-nvim-lsp
mkdir -p ~/.config/nvim/pack/cmp_luasnip/start/ && cd  ~/.config/nvim/pack/cmp_luasnip/start/ && git clone https://github.com/saadparwaiz1/cmp_luasnip
mkdir -p ~/.config/nvim/pack/LuaSnip/start/ && cd  ~/.config/nvim/pack/LuaSnip/start/ && git clone https://github.com/L3MON4D3/LuaSnip
mkdir -p ~/.config/nvim/pack/cmp-buffer/start/ && cd  ~/.config/nvim/pack/cmp-buffer/start/ && git clone https://github.com/hrsh7th/cmp-buffer
mkdir -p ~/.config/nvim/pack/cmp-path/start/ && cd  ~/.config/nvim/pack/cmp-path/start/ && git clone https://github.com/hrsh7th/cmp-path
mkdir -p ~/.config/nvim/pack/cmp-cmdline/start/ && cd  ~/.config/nvim/pack/cmp-cmdline/start/ && git clone https://github.com/hrsh7th/cmp-cmdline

mkdir -p ~/.config/nvim/pack/nvim-treesitter/start/ && cd  ~/.config/nvim/pack/nvim-treesitter/start/ && git clone https://github.com/nvim-treesitter/nvim-treesitter
mkdir -p ~/.config/nvim/pack/nvim-treesitter-textobjects/start/ && cd  ~/.config/nvim/pack/nvim-treesitter-textobjects/start/ && git clone https://github.com/nvim-treesitter/nvim-treesitter-textobjects
mkdir -p ~/.config/nvim/pack/nvim-treesitter-context/start/ && cd  ~/.config/nvim/pack/nvim-treesitter-context/start/ && git clone https://github.com/nvim-treesitter/nvim-treesitter-context
mkdir -p ~/.config/nvim/pack/nvim-treesitter-refactor/start/ && cd  ~/.config/nvim/pack/nvim-treesitter-refactor/start/ && git clone https://github.com/nvim-treesitter/nvim-treesitter-refactor

mkdir -p ~/.config/nvim/pack/plenary/start && cd ~/.config/nvim/pack/plenary/start && git clone https://github.com/nvim-lua/plenary.nvim
mkdir -p ~/.config/nvim/pack/nvim-telescope/start && cd ~/.config/nvim/pack/nvim-telescope/start && git clone https://github.com/nvim-telescope/telescope.nvim 

mkdir -p ~/.config/nvim/pack/nvim-telescope-fzf-native/start && cd ~/.config/nvim/pack/nvim-telescope-fzf-native/start && git clone https://github.com/nvim-telescope/telescope-fzf-native.nvim
# cd ~/.config/nvim/pack/nvim-telescope-fzf-native/ && cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build
cd ~/.config/nvim/pack/nvim-telescope-fzf-native/start/telescope-fzf-native.nvim && make;

mkdir -p ~/.config/nvim/pack/nvim-telescope-symbols/start && cd ~/.config/nvim/pack/nvim-telescope-symbols/start && git clone https://github.com/nvim-telescope/telescope-symbols.nvim 

mkdir -p ~/.config/nvim/pack/which-key/start && cd ~/.config/nvim/pack/which-key/start && git clone https://github.com/folke/which-key.nvim 


