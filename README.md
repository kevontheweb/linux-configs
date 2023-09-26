# linux-configs

my configs. I use zsh, and neovim. my old bashrc and vim configs are also there as well as configs for sway and some other applications.
> im back on bash for now.

## nvim_minimal

the nvim_minimal config does not use a package manager and tries to use few plugins. 
plugins are in pack.zip, just extract them i still need to write a script to clone them automatically 
lsps should be installed and available in your `$PATH` (this config doesnt use mason)
the file tree should look like this
```text
./
|-- after/
|   `-- plugin/
|       `-- fuzz.lua
|-- ftplugin/
|   |-- cpp.lua
|   |-- lua.lua
|   |-- markdown.lua
|   |-- netrw.lua
|   |-- python.lua
|   `-- rust.lua
|-- lua/
|   `-- k/
|       |-- cmp.lua
|       |-- configs.lua
|       |-- keymaps.lua
|       |-- lsp.lua
|       |-- statusline.lua
|       `-- treesitter.lua
|-- pack/
|   |-- Comment.nvim/
|   |   `-- start/
|   |-- LuaSnip/
|   |   `-- start/
|   |-- cmp-buffer/
|   |   `-- start/
|   |-- cmp-cmdline/
|   |   `-- start/
|   |-- cmp-nvim-lsp/
|   |   `-- start/
|   |-- cmp-path/
|   |   `-- start/
|   |-- cmp_luasnip/
|   |   `-- start/
|   |-- gitsigns.nvim/
|   |   `-- start/
|   |-- nightfox.nvim/
|   |   `-- start/
|   |-- nvim-cmp/
|   |   `-- start/
|   |-- nvim-lspconfig/
|   |   `-- start/
|   |-- nvim-treesitter/
|   |   `-- start/
|   |-- nvim-treesitter-context/
|   |   `-- start/
|   |-- nvim-treesitter-refactor/
|   |   `-- start/
|   `-- nvim-treesitter-textobjects/
|       `-- start/
`-- init.lua
```
