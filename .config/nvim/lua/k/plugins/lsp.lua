-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
	-- NOTE: Remember that lua is a real programming language, and as such it is possible
	-- to define small helper and utility functions so you don't have to repeat yourself
	-- many times.
	--
	-- In this case, we create a function that lets us more easily define mappings specific
	-- for LSP related items. It sets the mode, buffer and description for us each time.
	-- helper function (i refactored this out)
	-- local vim.keymap.set = function(keys, func, desc)
	-- 	if desc then
	-- 		desc = 'LSP: ' .. desc
	-- 	end
	--
	-- 	vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
	-- end

	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr, desc = 'LSP: [R]e[n]ame' })
	vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'LSP: [C]ode [A]ction' })

	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'LSP: [G]oto [D]efinition' })
	vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references,
		{ buffer = bufnr, desc = 'LSP: [G]oto [R]eferences' })
	vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, { buffer = bufnr, desc = 'LSP: [G]oto [I]mplementation' })
	vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, { buffer = bufnr, desc = 'LSP: Type [D]efinition' })
	vim.keymap.set('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols,
		{ buffer = bufnr, desc = 'LSP: [D]ocument [S]ymbols' })
	vim.keymap.set('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols,
		{ buffer = bufnr, desc = 'LSP: [W]orkspace [S]ymbols' })

	-- See `:help K` for why this keymap
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'LSP: Hover Documentation' })
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help,
		{ buffer = bufnr, desc = 'LSP: Signature Documentation' })

	-- Lesser used LSP functionality
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = 'LSP: [G]oto [D]eclaration' })
	vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder,
		{ buffer = bufnr, desc = 'LSP: [W]orkspace [A]dd Folder' })
	vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder,
		{ buffer = bufnr, desc = 'LSP: [W]orkspace [R]emove Folder' })
	vim.keymap.set('n', '<leader>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, { buffer = bufnr, desc = 'LSP: [W]orkspace [L]ist Folders' })

	-- Create a command `:Format` local to the LSP buffer
	-- (this conflicts with formatter.nvim)
	vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
		vim.lsp.buf.format()
	end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
	clangd = {},
	pyright = {
		{
			python = {
				analysis = {
					autoSearchPaths = true,
					diagnosticMode = 'workspace',
					useLibraryCodeForTypes = true
				}
			},
			single_file_support = true,
		}
	},
	rust_analyzer = {},
	tsserver = {},
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
	ltex = {
	},
	texlab = {
		filetypes = { 'bib', 'plaintex', 'latex' },
	},
	marksman = {},
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
