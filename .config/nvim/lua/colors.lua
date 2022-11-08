-------------------------------------------------------------------------------
-- Colorscheme setup
-------------------------------------------------------------------------------
require("catppuccin").compile()
require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "mocha"
    },
    compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
    transparent_background = true,
    term_colors = false,
    dim_inactive = {enabled = true, shade = "dark", percentage = 0.25},
    styles = {
        comments = {"italic"},
        conditionals = {},
        loops = {},
        functions = {},
        keywords = {"italic"},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {}
    },
    color_overrides = {},
    custom_highlights = {},
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        treesitter = true
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    }
})
-------------------------------------------------------------------------------
