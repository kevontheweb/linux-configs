-- https://dx13.co.uk/articles/2023/04/24/neovim-lsp-without-plugins/
--
local lspconfig = require('lspconfig')
lspconfig.marksman.setup {} -- copied binary to .config/nvim/lua/lsps/
lspconfig.prosemd_lsp.setup {} -- copied binary to .config/nvim/lua/lsps/
lspconfig.pyright.setup { -- installed with pip
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
lspconfig.lua_ls.setup {} -- installed with dnf (maybe a copr repo, can't remember)
lspconfig.clangd.setup {} -- installed with dnf
lspconfig.rust_analyzer.setup { -- installed with rustup
	settings = {
		['rust-analyzer'] = {},
	},
}

vim.keymap.set('n', 'KD', vim.diagnostic.open_float, { desc = 'Show diagnostics hover' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
vim.keymap.set('n', '[e', '<cmd>lua vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })<cr>',
	{ desc = 'Go to previous error' })
vim.keymap.set('n', ']e', '<cmd>lua vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.E })<cr>',
	{ desc = 'Go to previous error' })                                                                                                  -- only works as a vim cmd not straight lua 🤷

vim.cmd [[packadd cfilter]]
vim.keymap.set('n', '<leader>q', vim.diagnostic.setqflist, { desc = 'Fill qf list with diagnostics' })  -- fill qf list with diagnostics
vim.keymap.set('n', '<leader>l', vim.diagnostic.setloclist, { desc = 'Fill loclist with diagnostics' }) -- fill loclist with diagnostics
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
	{ desc = 'toggle quickfix list' }
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
	{ desc = 'toggle local list' }
)

vim.keymap.set("n", "gO", vim.lsp.buf.document_symbol, { noremap = true }, { desc = "Show document symbols in quickfix list" })

vim.keymap.set('n', ']q', vim.cmd.cnext, { desc = 'Next quickfix' }) -- quickfix
vim.keymap.set('n', '[q', vim.cmd.cprev, { desc = 'Previous quickfix' })
vim.keymap.set('n', ']l', vim.cmd.lnext, { desc = 'Next loclist' }) -- loclist
vim.keymap.set('n', '[l', vim.cmd.lprev, { desc = 'Previous loclist' })

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set('n', 'gC', vim.lsp.buf.code_action, opts, { desc = 'Code action' })
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts, { desc = 'Show declaration' })
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts, { desc = 'Show definition' })
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts, { desc = 'Show hover' })
		vim.keymap.set('n', 'Kd', vim.lsp.util.preview_location, opts, { desc = 'Show location' })
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts, { desc = 'Show implementation' })
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts, { desc = 'Show signature help' })
		vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts,
			{ desc = 'Add workspace folder' })
		vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts,
			{ desc = 'Remove workspace folder' })
		vim.keymap.set('n', '<leader>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts, { desc = 'List workspace folders' })
		vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts, { desc = 'Show type definition' })
		vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts, { desc = 'LSP Rename' })
		vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts, { desc = 'LSP Code Action' })
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts, { desc = 'LSP References' })
		vim.keymap.set({'n', 'v'}, 'gq', function()
			vim.lsp.buf.format { async = true }
		end, opts, { desc = 'LSP Format' })
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


vim.diagnostic.config({
	virtual_text = {
		format = function(diagnostic)
			local lines = vim.split(diagnostic.message, '\n')
			return lines[1]
		end,
		virt_text_pos = 'right_align',
		virt_text_win_col = 120,
		suffix = ' ',
		prefix = '●',
		spacing = 4,
	},
	signs = true,
	underline = true,
	update_in_insert = false, -- update diagnostics in insert mode (not default)
	severity_sort = true,
	float = { border = "rounded", max_width = 120 },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
	vim.lsp.handlers.hover,
	{ border = "rounded", max_width = 120 }
)

-- local signs = { Error = "✗ ", Warn = "⚠ ", Hint = "➤ ", Info = "🛈 " }
-- local signs = { Error = "█", Warn = "█", Hint = "█", Info = "█" }
local signs = { Error = "▌", Warn = "▌", Hint = "▌", Info = "▌" }

-- icons for status column
-- for type, icon in pairs(signs) do
-- 	local hl = "DiagnosticSign" .. type
-- 	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
-- end
