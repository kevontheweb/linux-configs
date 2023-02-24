-- onedark
-- require('onedarkpro').setup({theme = 'onedark_dark'})
-- vim.cmd('colorscheme onedarkpro')
-- catppuccin
-- require('catpuccin')
--[[
require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "mocha"
    },
    transparent_background = false,
    term_colors = false,
    compile = {enabled = true, path = vim.fn.stdpath("cache") .. "/catppuccin"},
    dim_inactive = {enabled = false, shade = "dark", percentage = 0.35},
    styles = {comments = {"italic"}, strings = {"italic"}},
    integrations = {
        gitsigns = true,
        telescope = true,
        treesitter = true,
        cmp = true,
        nvimtree = {enabled = true, show_root = true},
        dap = {enabled = true, enable_ui = true},
        native_lsp = {enabled = true}
    }
})
--]] -- vim.cmd('colorscheme catppuccin')
-- vim.cmd('Catppuccin mocha')
-- github
-- vim.cmd('colorscheme github')
require('github-theme').setup({
    theme_style = 'dark_default',
    function_style = 'italic',
    dark_sidebar = true,
    dark_float = true,
    sidebars = {'qf', 'vista_kind', 'terminal', 'packer'},
    transparent = true

})
