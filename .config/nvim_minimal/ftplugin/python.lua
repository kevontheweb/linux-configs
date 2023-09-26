require'lspconfig'.pyright.setup{}
local function got_output(channel, msg, name)
	-- vim.fn.append(vim.fn.line('$') - 1, msg) -- append to lines under cursor in buffer
	print(msg[1])
end

-- run python
vim.keymap.set(
	'n',
	'<leader>mk',
	function()
		vim.cmd.write()
		local cwd = vim.fn.getcwd()
		local buff = vim.api.nvim_get_current_buf()
		local filename = vim.api.nvim_buf_get_name(buff)
		vim.fn.jobstart({ 'python3', filename },
			{ text = true, cwd = cwd, on_stderr = got_output, on_stdout = got_output })
	end,
	{ desc = '[R]un [P]ython' },
	{ noremap = true }
)

-- vim.o.formatexpr = 'black %' -- doesn't work

-- overwrite vim.lsp.buf.format() keybind
vim.keymap.set(
	'n',
	'gq',
	function()
		vim.cmd.write()
		local cwd = vim.fn.getcwd()
		local filename = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
		vim.fn.jobstart({ 'black', filename },
			{
				cwd = cwd,
				on_stderr = got_output,
				on_stdout = got_output,
				on_exit = function() vim.cmd.edit(filename) end
			})
	end,
	{ desc = 'format python file using black' },
	{ force = true }
)

-- format on save
-- vim.api.nvim_create_autocmd("bufWritePost", {
-- 	pattern = "*.py",
-- 	command = "silent !black %",
-- })
