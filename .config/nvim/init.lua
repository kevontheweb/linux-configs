require('plugins')

if vim.g.vscode then
    print('disabling lsp and stuff')
else
    require('toggleterm')

    -- colorscheme
    vim.opt.termguicolors = true
    vim.opt.background = 'dark'
    require('colorschemes')

    -- my vanilla statusline
    require('statusline')

    -- file explorer (toggle with <leader>e)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
end

-------------------------------------------------------------------------------
-- configs
-------------------------------------------------------------------------------

vim.keymap.set('n', '<space>', '<nop>', {noremap = true}) -- toggle comments
vim.g.mapleader = ';' -- i am using the default now ('/')

vim.opt.number = true

vim.opt.tabstop = 2
vim.opt.smarttab = true
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.filetype.indent = true
vim.opt.autoindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

vim.opt.splitright = true

vim.opt.pumheight = 12
vim.opt.showmatch = true

vim.opt.cursorline = true

-- vim.opt.autochdir = true
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
vim.bo.formatoptions = 'jnlqr'

-- autocmds
if vim.g.vscode then
    print('not loading autocmds')
else
    -- Remove whitespace on save
    vim.api.nvim_create_autocmd('BufWritePre',
                                {pattern = '', command = ':%s/\\s\\+$//e'})

    -- Don't auto commenting new lines
    vim.api.nvim_create_autocmd('BufEnter', {
        pattern = '',
        command = 'set fo-=c fo-=r fo-=o'
    })

    -- spell check
    vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
        pattern = {'*.txt', '*.md', '*.tex'},
        command = 'setlocal spell'
    })
    -- auto save md files
    vim.api.nvim_create_autocmd('InsertLeave',
                                {pattern = '*.md', command = ':w'})
    vim.api.nvim_create_autocmd('TermOpen', {
        pattern = '*',
        command = 'setlocal statusline=%{b:term_title}'
    })
end

-- spelling
vim.opt.spell = true
vim.opt.spelllang = {'en_gb'}
vim.opt.spelloptions = {'camel'}

-- completion menus
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

-- keymaps
-- global
vim.keymap.set('n', '<leader>;', 'A;<cr>', {noremap = true}) -- insert ; at end of line and open new line in insert mode
if vim.g.vscode then
    -- vscode specific
    print('not loading keymaps')
    vim.keymap.set('n', 'gcc', '<c-/>', {noremap = true}) -- toggle comments
    vim.keymap.set('v', 'gb', '<c-s-a>', {noremap = true}) -- toggle comments
    vim.keymap.set('v', 'gc', '<c-/>', {noremap = true}) -- toggle comments
    -- vim.keymap.set('n', '<c-t>', '<c-`>', {noremap = true}) -- toggle terminal
else
    -- nvim specific
    vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', {noremap = true})
    vim.keymap.set('n', '<leader>f', ':FZF ./<cr>', {noremap = true})

    vim.keymap.set('n', '<m-z>', ':set wrap!<cr>', {noremap = true}) -- toggle wrapping with alt z (like vscode)
    vim.keymap.set('i', '<c-s>', '<esc>:w<cr>', {noremap = true}) -- ctrl s to save in insert mode
    vim.keymap.set('n', '<c-s>', ':w<cr>', {noremap = true}) -- ctrl s to save in normal mode

    vim.keymap.set({'n', 't'}, '<m-d>', ToggleTerminal) -- toggle terminal
    vim.keymap.set('t', '<esc>', '<c-\\><c-n>', {noremap = true})
    -- vim.keymap.set('i', '<c-bs>', '<c-w>', { noremap = true }) -- not working?
end
