-- [[ Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
	-- Add languages to be installed here that you want installed for treesitter
	ensure_installed = {
		'markdown',
		'markdown_inline',
		'latex',
		'bibtex',
		'html',
		'css',
		'c',
		'cpp',
		'python',
		'rust',
		'tsx',
		'typescript',
		'vim',
		'lua',
		'org',
	},
	additional_vim_regex_highlighting = { 'org' },

	-- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
	auto_install = true,

	highlight = {
		enable = true,
		-- disable slow treesitter highlight for large files
		disable = function(lang, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,
	},

	indent = { enable = true, disable = { 'python'  } },

	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = 'gnn', -- set to `false` to disable one of the mappings
			node_incremental = 'grn',
			scope_incremental = 'grc',
			node_decremental = 'grm',
		},
	},


	refactor = {
		highlight_definitions = {
			enable = true,
			-- Set to false if you have an `updatetime` of ~100.
			clear_on_cursor_move = true,
		},
		smart_rename = {
			enable = true,
			-- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
			keymaps = {
				smart_rename = 'grr',
			},
		},
	},

	textobjects = {
		-- see https://github.com/nvim-treesitter/nvim-treesitter-textobjects for config, most of this is from examples
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				-- you can set descriptions for keymaps like this
				-- [']c'] = { query = '@class.outer', desc = 'Next class start' },
				['af'] = '@function.outer',
				['if'] = '@function.inner',
				['ac'] = '@class.outer',
				['ic'] = '@class.inner',
				['as'] = '@scope',
			},
			selection_modes = {
				['@parameter.outer'] = 'v', -- charwise
				['@function.outer'] = 'V', -- linewise
				['@class.outer'] = '<c-v>', -- blockwise
			},
			include_surrounding_whitespace = false,
		},
		lsp_interop = {
			enable = true,
			border = 'none',
			floating_preview_opts = {},
			peek_definition_code = {
				['<leader>df'] = '@function.outer',
				['<leader>dF'] = '@class.outer',
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				[']m'] = '@function.outer',
				[']c'] = '@class.outer',
			},
			goto_next_end = {
				[']M'] = '@function.outer',
				[']C'] = '@class.outer',
			},
			goto_previous_start = {
				['[m'] = '@function.outer',
				['[c'] = '@class.outer',
			},
			goto_previous_end = {
				['[M'] = '@function.outer',
				['[C'] = '@class.outer',
			},
		},
		swap = {
			enable = true,
			swap_next = {
				['<leader>a'] = '@parameter.inner',
			},
			swap_previous = {
				['<leader>A'] = '@parameter.inner',
			},
		},
	},
}

-- treesitter folding
-- local function treesitter_folding()
-- 	vim.opt.foldmethod = 'expr'
-- 	vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
-- 	-- vim.cmd [[set nofoldenable]]
-- end
-- -- treesitter_folding()

local ts_repeat_move = require 'nvim-treesitter.textobjects.repeatable_move'

-- Repeat movement with ; and ,
-- ensure ; goes forward and , goes backward regardless of the last direction
-- vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move_next)
-- vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_previous)

-- vim way: ; goes to the direction you were moving.
vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move)
vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_opposite)

-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f)
vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F)
vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t)
vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T)

require 'treesitter-context'.setup({
	enable = false, -- using barbeque
	max_lines = 0,
	min_window_height = 0,
	line_numbers = true,
	multiline_threshold = 20,
	trim_scope = 'outer',
	mode = 'topline',
	separator = nil,
	on_attach = function()
		-- vim.cmd [[hi TreesitterContextBottom gui=underline guisp=Grey]]
	end
})

vim.keymap.set('n', '[p', function()
	require('treesitter-context').go_to_context()
end, { silent = true }, { desc = 'Go to parent context' })
