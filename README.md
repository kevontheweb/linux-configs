# linux-configs

my configs. I use zsh, and neovim. my old bashrc and vim configs are also there as well as configs for sway and some other applications.

> I'm back on bash for now.

## nvim

My main nvim config.
It doesn't use Mason, it still uses Lazy for package management.
LSPs are installed via system package manager (just need them on `$PATH`)
I try to not use plugins for simple things and have custom functions and autocmds for things.
I use a lot of treesitter features.
Telescope is a must. I tried to live without it, but it makes life quite a bit easier for fuzzy finding.

![nvim screenshot](./nvim.png)

## nvim_minimal

The `nvim_minimal` config does not use a package manager and tries to use few plugins.
Plugins are in pack.zip, just extract them.
I still need to write a script to clone them automatically
LSPs should be installed and available in your `$PATH` (this config doesn't use mason)
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
