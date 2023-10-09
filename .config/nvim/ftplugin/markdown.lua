-- [[ markdown ]]
require 'lspconfig'.marksman.setup {}
require 'lspconfig'.prosemd_lsp.setup {}
-- require 'lspconfig'.remark_ls.setup {}

vim.b.wrap = true
vim.b.textwidth = 80
vim.o.spell = true

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

vim.keymap.set('n', '<leader>mk',
	'<cmd>!pandoc % -f markdown+bracketed_spans -t pdf --csl ~/Documents/Tuks/2023/EPR400/ieee.csl -V geometry:margin=1.5cm -V geometry:paper=a4paper --pdf-engine lualatex -C -so "%:r.pdf" && xdg-open %:r.pdf<cr>',
	{ desc = 'Compile and open markdown document' }
)

-- prettier formatting with gq
vim.bo.formatprg='prettier --stdin-filepath %'
