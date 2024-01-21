-- [[ markdown ]]
-- require 'lspconfig'.marksman.setup {}
-- require 'lspconfig'.prosemd_lsp.setup {}
-- require 'lspconfig'.remark_ls.setup {}

vim.b.wrap = true
vim.o.textwidth = 120
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


-- compile doc asynchronously
local function got_output(channel, msg, name)
	-- vim.fn.append(vim.fn.line('$') - 1, msg) -- append to lines under cursor in buffer
	print(msg[1])
end

vim.keymap.set(
	'n',
	'<leader>mk',
	function()
		vim.cmd.write()
		local cwd = vim.fn.getcwd()
		local buff = vim.api.nvim_get_current_buf()
		local filename = vim.api.nvim_buf_get_name(buff)
		local pdfname = filename.gsub(filename, '.md', '.pdf')
		local cmd = vim.fn.jobstart(
			{ 'pandoc', filename,
				'-f',
				'markdown+bracketed_spans',
				'-t',
				'pdf',
				'--bibliography',
				os.getenv('HOME') .. '/Documents/Tuks/2023/EPR400/project.bib',
				'--csl',
				os.getenv('HOME') .. '/Documents/Tuks/2023/EPR400/ieee.csl',
				'-V',
				'geometry:margin=1.5cm',
				'-V',
				'geometry:paper=a4paper',
				'--pdf-engine',
				'lualatex',
				'-C',
				'-so',
				pdfname,
			},
			{ text = true, cwd = cwd, on_stderr = got_output, on_stdout = got_output }
		)
		if cmd then
			-- vim.fn.jobstart({ 'xdg-open', pdfname },
			-- 	{ text = true, cwd = cwd, on_stderr = got_output, on_stdout = got_output })
			vim.fn.system('xdg-open ' .. pdfname)
		end
	end,
	{ desc = '[m]a[k]e pdf with pandoc' },
	{ noremap = true }
)

-- prettier formatting with gq
vim.bo.formatprg = 'prettier --stdin-filepath %'
