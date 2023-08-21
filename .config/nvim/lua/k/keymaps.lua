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

-- jump to end of words with tab in normal and visual mode.
vim.keymap.set({ 'n', 'v' },
	'<Tab>',
	'e',
	{ silent = true }
)

-- toggle file tree (24 characters wide)
vim.keymap.set({ 'n', 'v' },
	'<leader>e',
	'<cmd>24Lexplore<CR>',
	{ silent = true },
	{ desc = '[E]xplore' }
)

-- select all with `ga`
vim.keymap.set({ 'n' },
	'yga',
	'ggVG$y<c-o>',
	{ silent = true },
	{ desc = '[Y]ank [G] [A]ll' }
)

-- centre cursor in middle of screen horizontally and vertically (for suuuuuper long lines that you don't want to wrap)
vim.keymap.set({ 'n' },
	'<leader>z',
	'zzzszH',
	{ noremap = true },
	{ desc = '[Z]oom: centre cursor horizontally and vertically' }
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
	'<c-\\><c-n><c-w>',
	{ noremap = true }
)

-- <c-s> saves in insert mode
vim.keymap.set({ 'i' },
	'<c-s>',
	'<cmd>w<CR>',
	{ noremap = true }
)

-- <meta-z> toggle wrapping (like in vscode)
vim.keymap.set({ 'n' },
	'<leader>sw',
	'<cmd>set wrap!<cr>',
	{ noremap = true },
	{ desc = '[S]et [W]rap' }
)

-- Diagnostic keymaps
vim.keymap.set('n',
	'[d',
	vim.diagnostic.goto_prev,
	{ desc = 'Go to previous diagnostic message' }
)

vim.keymap.set('n',
	']d',
	vim.diagnostic.goto_next,
	{ desc = 'Go to next diagnostic message' }
)

vim.keymap.set('n',
	'KD',
	vim.diagnostic.open_float,
	{ desc = 'Hover diagnostic message' }
)

vim.keymap.set('n',
	-- toggle quickfix
	'<leader>qf',
	function()
		local winid = vim.fn.getqflist({ winid = 0 }).winid
		if winid ~= 0 then
			vim.cmd.cclose()
		else
			vim.diagnostic.setqflist()
			vim.cmd.copen()
		end
	end,
	-- '<CMD>lua require"k.utils".toggle_qf("q")<CR>',
	{ desc = 'Open diagnostics in [Q]uick[f]ix' }
)

vim.keymap.set('n',
	']e',
	vim.cmd.cnext,
	{ desc = 'Go to ]next [e]rror from [q]uick[f]ix list' }
)

vim.keymap.set('n',
	'[e',
	vim.cmd.cprev,
	{ desc = 'Go to [previous [e]rror from [q]uick[f]ix list' }
)

vim.keymap.set('n',
	-- toggle quickfix
	'<leader>ll',
	function()
		local winid = vim.fn.getloclist(0, { winid = 0 }).winid
		if winid ~= 0 then
			vim.cmd.lclose()
		else
			vim.diagnostic.setloclist()
			vim.cmd.lopen()
		end
	end,
	{ desc = 'Open diagnostics in [Q]uick[f]ix' }
)

vim.keymap.set('n',
	']w',
	vim.cmd.lnext,
	{ desc = 'Go to ]next [e]rror from [q]uick[f]ix list' }
)

vim.keymap.set('n',
	'[w',
	vim.cmd.lprev,
	{ desc = 'Go to [previous [e]rror from [q]uick[f]ix list' }
)

-- centre window for jumps
-- vim.keymap.set('n', '{', '{zz')
-- vim.keymap.set('n', '}', '}zz')
-- vim.keymap.set('n', 'N', 'Nzz')
-- vim.keymap.set('n', 'n', 'nzz')
