-- [[ Custom Keymaps ]]
-- some keymaps are still in other relevant modules like the treesitter-textobjects and telescope keymaps

-- select all with `ga`
vim.keymap.set({ 'n' }, 'ga', 'ggVG$', { silent = true }, { desc = '[E]xplore' })

-- don't move forward with space (makes using space as leader better)
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- toggle file tree (24 characters wide)
vim.keymap.set({ 'n', 'v' }, '<leader>e', '<cmd>24Lexplore<CR>', { silent = true }, { desc = '[E]xplore' })

-- centre cursor in middle of screen horizontally and vertically (for suuuuuper long lines that you don't want to wrap)
vim.keymap.set({ 'n' }, '<leader>z', 'zzzszH', { noremap = true },
	{ desc = '[Z]oom: centre cursor horizontally and vertically' })

-- open terminal
vim.keymap.set({ 'n', 't' }, '<leader>t', '<cmd>split<CR><c-w><c-j><cmd>terminal<CR>a', { noremap = true },
	{ desc = '[T]erminal' })

-- toggle focus terminal
vim.keymap.set({ 't' }, '<c-w>', '<c-\\><c-n><c-w>', { noremap = true })

-- <c-s> saves in insert mode
vim.keymap.set({ 'i' }, '<c-s>', '<cmd>w<CR>', { noremap = true })

-- <meta-z> toggle wrapping (like in vscode)
vim.keymap.set({ 'n' }, '<leader>sw', '<cmd>set wrap!<cr>', { noremap = true },
	{ desc = '[S]et [W]rap' })

-- keybind format (this keymap is now configured in 'lua/k/formatter.lua')
-- vim.keymap.set("n", "<leader>fc", vim.lsp.buf.format, { desc = "[F]ormat using [L]SP" })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set('n', '<leader>D', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- centre window for jumps
-- vim.keymap.set('n', '{', '{zz')
-- vim.keymap.set('n', '}', '}zz')
-- vim.keymap.set('n', 'N', 'Nzz')
-- vim.keymap.set('n', 'n', 'nzz')

-- open file_browser with the path of the current buffer
vim.keymap.set(
	"n",
	"<space>fb",
	require "telescope".extensions.file_browser.file_browser,
	{ desc = "Telescope [f]ile [b]rowser" },
	{ noremap = true }
)

-- format markdown tables (this is now done with prettierd using formatter.nvim)
-- https://jcuenod.github.io/bibletech/2023/03/14/formatting-md-tables-in-neovim/
-- vim.keymap.set(
-- 	'v',
-- 	'<leader>ft',
-- 	':!pandoc -t gfm<cr>',
-- 	{ desc = "[f]ormat [t]able" },
-- 	{ noremap = true }
-- )

-- [[ compiling and running ]]
-- run python
vim.keymap.set(
	'n',
	'<leader>rp',
	function()
		vim.cmd.write()
		local cwd = vim.fn.getcwd()
		local buff = vim.api.nvim_get_current_buf()
		local filename = vim.api.nvim_buf_get_name(buff)
		-- vim._system({ "python3", filename }, { text = true, cwd = cwd }, on_exit)
		vim.fn.jobstart({ "python3", filename }, { text = true, cwd = cwd })
	end,
	{ desc = "[R]un [P]ython" },
	{ noremap = true }
)

-- compile md
vim.keymap.set('n', '<leader>cm', '<cmd>!../../compile.sh %<cr>', { desc = "Compile and open markdown document" })
