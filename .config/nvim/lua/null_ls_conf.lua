-- null-ls setup (formatting)
require("mason-null-ls").setup({
	ensure_installed = {
		-- vim.tbl_keys(formatters), -- Opt to list sources here, when available in mason.
		'black',
		'clang_format',
		'prettierd',
	},
	automatic_installation = true,
	automatic_setup = true, -- Recommended, but optional
})
