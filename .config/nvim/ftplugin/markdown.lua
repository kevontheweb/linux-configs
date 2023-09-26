vim.o.spell = true
require 'lspconfig'.marksman.setup {}
require 'lspconfig'.prosemd_lsp.setup {}
-- require 'lspconfig'.remark_ls.setup {}

vim.g.markdown_fenced_languages = {
	"bash=sh",
	"sh",
	"lua",
	"python",
	"py=python",
	"rust",
	"rs=rust",
	"c",
	"cpp",
	"markdown",
	"md=markdown",
	"latex",
	"html",
	"css",
	"javascript",
	"js=javascript",
	"json",
	"gnuplot",
	"gp=gnuplot",
	"gpi=gnuplot",
	"bibtex",
}

-- compile md
vim.keymap.set('n', '<leader>mk', '<cmd>!../../compile.sh %<cr>', { desc = 'Compile and open markdown document' })

vim.b.wrap = true
vim.b.textwidth = 80

vim.keymap.set(
	{ 'n', 'v' },
	'gqp',
	'%!prettier --stdin-filepath %<CR>',
	{ desc = 'Format markdown' },
	{ noremap = true }
)

vim.cmd [[setlocal formatprg=prettier\ --stdin]]
