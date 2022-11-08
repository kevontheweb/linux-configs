require('plugins')
if vim.g.vscode then
    print('disabling lsp and stuff')
else
    require('lsp')
    require('formatting')
end

require('colors')
require('tree-sitter')
require('statusline')

require('Comment').setup()
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup({
    renderer = {
        icons = {
            show = {
                file = false,
                folder = false,
                folder_arrow = false,
                git = false
            }
        }
    }
})

-- pip install pynvim

-------------------------------------------------------------------------------
-- configs
-------------------------------------------------------------------------------
-- vim.g.mapleader = ";" -- i am using the defualt now ('/')
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.cmd.colorscheme "catppuccin"
vim.opt.number = true

vim.opt.tabstop = 2
vim.opt.smarttab = true
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.filetype.indent = true
vim.opt.autoindent = true

vim.opt.smartcase = true
vim.opt.incsearch = true

vim.opt.pumheight = 12
vim.opt.showmatch = true

vim.opt.cursorline = true

vim.opt.autochdir = true
vim.opt.mouse = 'a'
vim.opt.mousemodel = 'popup'

-- render whites
vim.opt.listchars = {
    eol = '¬',
    tab = '>-',
    trail = '·',
    extends = '»',
    precedes = '»',
    nbsp = '·'
}
vim.opt.list = false
-- vim.wo.colorcolumn = '100'
vim.opt.wrap = false
vim.opt.linebreak = true

-- auto save md files
vim.api.nvim_create_autocmd("InsertLeave", {pattern = "*.md", command = ":w"})

-- Remove whitespace on save
vim.api.nvim_create_autocmd('BufWritePre',
                            {pattern = '', command = ":%s/\\s\\+$//e"})

-- Don't auto commenting new lines
vim.api.nvim_create_autocmd('BufEnter',
                            {pattern = '', command = 'set fo-=c fo-=r fo-=o'})

-- spell check
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = {"*.txt", "*.md", "*.tex"},
    command = "setlocal spell"
})
vim.opt.spellsuggest = best, 9
vim.opt.spelloptions = "camel"
vim.opt.spelllang = {'en_gb'}

-- comnpletion menus
vim.opt.completeopt = {"menu", "menuone", "noselect"}

-- keymaps
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", {noremap = true})
-- vim.keymap.set("i", "<c-bs>", "<c-w>", { noremap = true }) -- not working?
vim.keymap.set("n", "<m-z>", ":set wrap!<cr>", {noremap = true})
vim.keymap.set("i", "<c-s>", "<esc>:w<cr>", {noremap = true})
vim.keymap.set("n", "<c-s>", ":w<cr>", {noremap = true})
vim.keymap.set("n", "<c-t>", ":sp<bar>term<cr><c-w>J:resize10<cr>a",
               {noremap = true})
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>:q", {noremap = true})
