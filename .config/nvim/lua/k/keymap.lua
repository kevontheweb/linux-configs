-- [[ Basic Keymaps ]]

-- don't move forward with space
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- toggle file tree
vim.keymap.set({ 'n', 'v' }, '<leader>e', '<cmd>Lexplore<CR>', { silent = true })

-- centre cursor in midlle of screen
vim.keymap.set({ 'n' }, '<leader>z', 'zzzszH', { noremap = true })

-- open terminal
vim.keymap.set({ 'n', 't' }, '<leader>t', '<cmd>split<CR><c-w><c-j><cmd>terminal<CR>a', { noremap = true })

-- toggle focus terminal
vim.keymap.set({ 'n', 't' }, '<c-t>', '<c-\\><c-n>', { noremap = true })

-- <c-s> saves in insert mode
vim.keymap.set({ 'i' }, '<c-s>', '<cmd>w<CR>a', { noremap = true })

-- <meta-z> toggle wrapping (like in vscode)
vim.keymap.set({ 'i' }, '<meta-z>', '<cmd>set wrap!<cr><cmd>lua vim.opt_local.columns=80<CR>i', { noremap = true })
vim.keymap.set({ 'n' }, '<meta-z>', '<cmd>set wrap!<CR><cmd>lua vim.opt_local.columns=80<CR>', { noremap = true })

-- keybind format
vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "[C]ode action: [F]ormat current buffer" })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set('n', '<leader>D', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- centre window for jumps
vim.keymap.set('n', '{', '{zz')
vim.keymap.set('n', '}', '}zz')
vim.keymap.set('n', 'N', 'Nzz')
vim.keymap.set('n', 'n', 'nzz')


-- open file_browser with the path of the current buffer
vim.keymap.set(
	"n",
	"<space>fb",
	require "telescope".extensions.file_browser.file_browser,
	{ noremap = true },
	{ desc = "Telescope [f]ile [b]rowser" }
)

-- format markdown tables
vim.keymap.set(
	'v',
	'<leader>ft',
	':!pandoc -t gfm<cr>',
	{ noremap = true },
	{ desc = "[f]ormat [t]able" }
)

