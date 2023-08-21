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

-- format markdown tables (this is now done with prettierd using formatter.nvim)
-- https://jcuenod.github.io/bibletech/2023/03/14/formatting-md-tables-in-neovim/
-- vim.keymap.set(
-- 	'v',
-- 	'<leader>ft',
-- 	':!pandoc -t gfm<cr>',
-- 	{ desc = '[f]ormat [t]able' },
-- 	{ noremap = true }
-- )
