lspconfig = require('lspconfig')
lspconfig.marksman.setup {}
lspconfig.prosemd_lsp.setup {}
lspconfig.pyright.setup {
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = 'workspace',
				typeCheckingMode = 'strict',
				autoImportCompletions = true,
			},
		},
		useLibraryCodeForTypes = true,
		single_file_support = true,
	}
}
lspconfig.lua_ls.setup {}
lspconfig.clangd.setup {}
lspconfig.rust_analyzer.setup {
	settings = {
		['rust-analyzer'] = {},
	},
}

vim.keymap.set('n', 'KD', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
-- vim.keymap.set('n', '[e', vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }))
-- vim.keymap.set('n', ']e', vim.diagnostic.goto_next({severity = vim.diagnostic.severity.E}))

vim.cmd [[packadd cfilter]]
vim.keymap.set('n', '<leader>q', vim.diagnostic.setqflist)  -- fill qf list with diagnostics
vim.keymap.set('n', '<leader>l', vim.diagnostic.setloclist) -- fill loclist with diagnostics
vim.keymap.set('n',
	-- toggle quickfix
	'<leader>qf',
	function()
		local winid = vim.fn.getqflist({ winid = 0 }).winid
		if winid ~= 0 then
			vim.cmd.cclose()
		else
			-- vim.diagnostic.setqflist()
			vim.cmd.copen()
		end
	end,
	-- '<CMD>lua require"k.utils".toggle_qf("q")<CR>',
	{ desc = 'Open diagnostics in [Q]uick[f]ix' }
)

vim.keymap.set('n',
	-- toggle locallist
	'<leader>ll',
	function()
		local winid = vim.fn.getloclist(0, { winid = 0 }).winid
		if winid ~= 0 then
			vim.cmd.lclose()
		else
			-- vim.diagnostic.setloclist()
			vim.cmd.lopen()
		end
	end,
	{ desc = 'Open diagnostics in [Q]uick[f]ix' }
)

vim.keymap.set("n", "gO", vim.lsp.buf.document_symbol, {noremap=true})

vim.keymap.set('n', ']q', vim.cmd.cnext) -- quickfix
vim.keymap.set('n', '[q', vim.cmd.cprev)
vim.keymap.set('n', ']l', vim.cmd.lnext) -- loclist
vim.keymap.set('n', '[l', vim.cmd.lprev)

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set('n', 'gC', vim.lsp.buf.code_action)
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', 'Kd', vim.lsp.util.preview_location)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set('n', '<leader>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		vim.keymap.set('n', 'gq', function()
			vim.lsp.buf.format { async = true }
		end, opts)
	end,
})

-- nicer UI
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization
-- set floating window properties
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = 'rounded'         -- 'double', 'straight'
	opts.max_width = opts.max_width or 120 -- max width 120
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local signs = { Error = "✗ ", Warn = "⚠ ", Hint = "➤ ", Info = "🛈 " }

vim.diagnostic.config({
	virtual_text = {
		format = function(diagnostic)
			local lines = vim.split(diagnostic.message, '\n')
			return lines[1]
		end,
		virt_text_pos = 'right_align',
		-- virt_text_win_col = 120,
		suffix = ' ',
		prefix = '●',
		-- spacing = 8,
	},
	signs = true,
	underline = true,
	update_in_insert = true, -- update diagnostics in insert mode (not default)
	severity_sort = true,
	float = { border = "rounded", max_width = 120 },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
	vim.lsp.handlers.hover,
	{ border = "rounded", max_width = 120 }
)

-- icons for status column
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
