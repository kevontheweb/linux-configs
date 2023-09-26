-- [[ Custom Keymaps ]]
-- some keymaps are still in other relevant modules like the treesitter-textobjects and telescope keymaps

-- fix my spelling mistakes
vim.api.nvim_create_user_command('W', '<cmd>w<cr>', { force = true })
vim.api.nvim_create_user_command('Q', '<cmd>q<cr>', { force = true })
vim.api.nvim_create_user_command('Wq', '<cmd>wq<cr>', { force = true })
vim.api.nvim_create_user_command('WQ', '<cmd>wq<cr>', { force = true })

-- don't move forward with space (makes using space as leader better)
vim.keymap.set({ 'n', 'v' },
	'<Space>',
	'<Nop>',
	{ silent = true }
)

-- previous jump with <c-i> (lowercase i)
-- vim.keymap.set({ 'n', 'v' },
-- 	'<c-i>',
-- 	'<c-I>',
-- 	{ silent = true }
-- )

-- toggle file tree (24 characters wide)
vim.keymap.set({ 'n', 'v' },
	'<leader>e',
	'<cmd>24Lexplore<CR>',
	{ noremap = true },
	{ silent = true },
	{ desc = '[E]xplore' }
)

-- select all with `yga`
vim.keymap.set({ 'n' },
	'yga',
	'ggVG$y<c-o>',
	{ silent = true },
	{ desc = '[Y]ank [G] [A]ll' }
)

-- open terminal
vim.keymap.set({ 'n', 't' },
	'<leader>t',
	'<cmd>split<CR><c-w><c-j><cmd>terminal<CR>a',
	{ noremap = true },
	{ desc = '[T]erminal' }
)

-- toggle focus terminal (allow for easy window change)
vim.keymap.set({ 't' },
	'<c-w>',
	'<c-\\><c-n>',
	{ noremap = true }
)

-- <c-s> saves in insert mode
vim.keymap.set({ 'i' },
	'<c-s>',
	'<cmd>w<CR>',
	{ noremap = true }
)

-- toggle wrapping
vim.keymap.set({ 'n' },
	'<leader>sw',
	'<cmd>set wrap!<cr>',
	{ noremap = true },
	{ desc = '[S]et [W]rap' }
)
