-- [[ Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
	defaults = {
		mappings = {
			i = {
				['<C-u>'] = false,
				['<C-d>'] = false,
			},
		},
	},
	extensions = {
		bibtex = {
			-- Path to global bibliographies (placed outside of the project)
			global_files = { '~/Documents/Tuks/2023/EPR400/project.bib' },
			search_keys = { 'author', 'year', 'title' },
			citation_format = '{{author}} ({{year}}), {{title}}.',
			context = true,
			context_fallback = true,
			wrap = false,
		},
	}

}

-- extensions
pcall(require('telescope').load_extension('fzf'))
pcall(require('telescope').load_extension('bibtex'))

local builtin = require('telescope.builtin')
local extensions = require('telescope').extensions

-- See `:help telescope.builtin`
vim.keymap.set(
	'n',
	'<leader>b',
	builtin.buffers,
	{ desc = 'Telescope: Find existing [b]uffers' }
)

vim.keymap.set(
	'n',
	'<leader>rf',
	builtin.oldfiles,
	{ desc = 'Telescope: Find [R]ecently opened [F]iles' }
)

vim.keymap.set(
	'n',
	'<leader><leader>',
	builtin.live_grep,
	{ desc = 'Telescope: [Fuzzy] find within all files in cwd (live grep)' }
)

vim.keymap.set(
	'n',
	'<leader>/',
	builtin.current_buffer_fuzzy_find,
	-- function()
	-- 	builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
	-- 		winblend = 10,
	-- 		previewer = false,
	-- 	})
	-- end,
	{ desc = '[/] Fuzzily search in current buffer' }
)

vim.keymap.set(
	'n',
	'<leader>f',
	builtin.find_files,
	{ desc = 'Telescope: Find [F]iles in cwd' }
)

vim.keymap.set(
	'n',
	'<leader>fr',
	builtin.lsp_references,
	{ desc = 'Telescope: [f]ind [references]' }
)

vim.keymap.set(
	'n',
	'<leader>skm',
	builtin.keymaps,
	{ desc = 'Telescope: [S]earch [K]ey [M]ap' }
)

vim.keymap.set(
	'n',
	'<leader>ss',
	builtin.lsp_workspace_symbols,
	{ desc = 'Telescope: [S]earch [S]ymbols in workspace (from LSP)' }
)

vim.keymap.set(
	'n',
	'<leader>sh',
	builtin.help_tags, { desc = 'Telescope: [S]earch [H]elp' }
)

vim.keymap.set(
	'n',
	'<leader>sw',
	builtin.grep_string,
	{ desc = 'Telescope: [S]earch current [W]ord' }
)

vim.keymap.set(
	'n',
	'<leader>sd',
	builtin.diagnostics,
	{ desc = 'Telescope: [S]earch [D]iagnostics' }
)

-- bib tex
vim.keymap.set(
	'n',
	'<leader>sc',
	'<cmd>:Telescope bibtex<cr>', -- extensions.bibtex.bibtex(),
	{ desc = '[sc]: search citations' },
	{ noremap = true }
)

-- improved lsp telescope keymaps
vim.keymap.set('n',
	'<leader>gr',
	require('telescope.builtin').lsp_references,
	{ buffer = bufnr, desc = 'LSP: [G]oto [R]eferences' }
)

vim.keymap.set('n',
	'<leader>ds',
	require('telescope.builtin').lsp_document_symbols,
	{ buffer = bufnr, desc = 'LSP: [D]ocument [S]ymbols' }
)

vim.keymap.set('n',
	'<leader>ws',
	require('telescope.builtin').lsp_dynamic_workspace_symbols,
	{ buffer = bufnr, desc = 'LSP: [W]orkspace [S]ymbols' }
)
