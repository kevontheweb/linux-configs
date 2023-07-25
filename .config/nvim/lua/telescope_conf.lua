-- [[ Configure Telescope ]]
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
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>b', require('telescope.builtin').buffers, { desc = 'Telescope: [ ] Find existing buffers' })
vim.keymap.set('n', '<leader>f', require('telescope.builtin').oldfiles,
	{ desc = 'Telescope: [?] Find recently opened files' })
vim.keymap.set('n', '<leader><leader>', require('telescope.builtin').live_grep,
	{ desc = 'Telescope: Fuzzy find within all files in cwd (live grep)' })
vim.keymap.set('n', '<leader>/', function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
		winblend = 10,
		previewer = false,
	})
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = 'Telescope: [S]earch [F]iles' })
vim.keymap.set('n', '<leader>ss', require('telescope.builtin').lsp_workspace_symbols,
	{ desc = 'Telescope: [S]earch [S]ymbols in workspace (from LSP)' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = 'Telescope: [S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string,
	{ desc = 'Telescope: [S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics,
	{ desc = 'Telescope: [S]earch [D]iagnostics' })
