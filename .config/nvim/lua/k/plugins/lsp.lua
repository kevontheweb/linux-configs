-- LSP settings.
-- to do :
-- [] get rid of mason (i dont install new lsps all the time)

--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
	-- lsp keympas
	vim.keymap.set('n',
		'gca',
		vim.lsp.buf.code_action,
		{ buffer = bufnr, desc = 'LSP: [G]oto [C]ode [A]ctions' }
	)
	vim.keymap.set('n',
		'gd',
		vim.lsp.buf.definition,
		{ buffer = bufnr, desc = 'LSP: [G]oto [D]efinition' }
	)
	vim.keymap.set('n', -- this gets run when there is an lsp and should override the treesitter one (must have treesitter before lsp in requires in the inti.lua)
		'rn',
		vim.lsp.buf.rename,
		{ buffer = bufnr, desc = 'LSP: [R]e[N]ame', remap = true }
	)
	vim.keymap.set("n",
		"gr",
		vim.lsp.buf.references,
		{ desc = "LSP: [G]o to [R]eference in quickfix" }
	)
	vim.keymap.set('n',
		'gI',
		vim.lsp.buf.implementation,
		{ buffer = bufnr, desc = 'LSP: [G]oto [I]mplementation' }
	)
	vim.keymap.set('n',
		'gD',
		vim.lsp.buf.declaration,
		{ buffer = bufnr, desc = 'LSP: [G]oto [D]eclaration' }
	)
	vim.keymap.set('n',
		'gp',
		vim.lsp.buf.type_definition,
		{ buffer = bufnr, desc = 'LSP: Ty[p]e definition' }
	)

	-- hovers
	vim.keymap.set('n',
		'K',
		vim.lsp.buf.hover,
		{ buffer = bufnr, desc = 'LSP: Hover Documentation' }
	)
	vim.keymap.set('n',
		'<C-k>',
		vim.lsp.buf.signature_help,
		{ buffer = bufnr, desc = 'LSP: Signature Documentation' }
	)
	vim.keymap.set('n',
		'Kd',
		vim.lsp.util.preview_location,
		{ buffer = bufnr, desc = 'LSP: [K] hover [D]efinition' }
	)

	-- improved telescope keymaps
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

	-- workspace stuff
	vim.keymap.set('n',
		'<leader>wa',
		vim.lsp.buf.add_workspace_folder,
		{ buffer = bufnr, desc = 'LSP: [W]orkspace [A]dd Folder' }
	)
	vim.keymap.set('n',
		'<leader>wr',
		vim.lsp.buf.remove_workspace_folder,
		{ buffer = bufnr, desc = 'LSP: [W]orkspace [R]emove Folder' }
	)
	vim.keymap.set('n',
		'<leader>wl',
		function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end,
		{ buffer = bufnr, desc = 'LSP: [W]orkspace [L]ist Folders' }
	)

	-- formatting
	if client.supports_method("textDocument/formatting") then
		vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])
		vim.o.formatexpr ='v:lua vim.lsp.buf.format()' -- enable range formatting for lsps that have formatting
		vim.keymap.set('n', 'gqb', -- format entire buffer
			function()
				vim.lsp.buf.format()
			end,
			{ desc = '[gq]: format current [B]uffer' }
		)
	end
end

-- Enable the following language servers
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
	clangd = {
		root_dir = [[
        root_pattern(
          '.clangd',
          '.clang-tidy',
          '.clang-format',
          'compile_commands.json',
          'compile_flags.txt',
          'configure.ac',
          '.git'
        )
      ]],
		capabilities = [[default capabilities, with offsetEncoding utf-8]],
	},
	pyright = {
		{
			python = {
				analysis = {
					autoSearchPaths = true,
					diagnosticMode = 'workspace',
					typeCheckingMode = 'strict',
					autoImportCompletions = true,
				},
				useLibraryCodeForTypes = true,
				single_file_support = true,
			},
		}
	},
	rust_analyzer = {},
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
	-- ltex = {},
	texlab = {},
	marksman = {},
	-- webdev stuff i dont even use
	tsserver = {},
	html = {},
	cssls = {},
	emmet_ls = {},
	jsonls = {},
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
	ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
	function(server_name)
		require('lspconfig')[server_name].setup {
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
		}
	end,
	-- override settings for texlab
	['texlab'] = function()
		require('lspconfig')['texlab'].setup {
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers['texlab'],
			-- 'filetypes' is set outside of 'setttings'
			filetypes = { 'markdown', 'bib', 'plaintex', 'latex' },
		}
	end
}

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
	virtual_text = { prefix = '●' },
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
local signs = { Error = "✗ ", Warn = "⚠ ", Hint = "➤ ", Info = "🛈 " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
