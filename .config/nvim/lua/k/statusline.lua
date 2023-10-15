-- [[ Status Line ]]

-- git branch
function os.capture(cmd, raw)
	local f = assert(io.popen(cmd, 'r'))
	local s = assert(f:read('*a'))
	f:close()
	if raw then return s end
	s = string.gsub(s, '^%s+', '')
	s = string.gsub(s, '%s+$', '')
	s = string.gsub(s, '[\n\r]+', ' ')
	return s
end

function status_line_git_branch()
	local branch = os.capture("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d \'\'")
	if branch ~= '' then
		return "[" .. branch .. "]"
	else
		return ""
	end
end

-- diagnostics
function status_line_diagnostics()
	local signs = { Error = "E:", Warn = "W:", Hint = "H:", Info = "I:" }
	-- local signs = { Error = "✗:", Warn = "⚠:", Hint = "➤:", Info = "🛈 :" }
	-- local signs = { Error = "⛔ ", Warn = "⚠️ ", Hint = "📎 ", Info = "ℹ️ " }
	if #vim.diagnostic.get() > 0 then
		return
		    "%#Comment#" .. " " .. "%#DiagnosticSignError#" ..
		    signs.Error .. tostring(#vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })) .. " "
		    ..
		    "%#DiagnosticSignWarn#" ..
		    signs.Warn .. tostring(#vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })) .. " "
		    ..
		    "%#DiagnosticSignHint#" ..
		    signs.Hint .. tostring(#vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })) .. " "
		    ..
		    "%#DiagnosticSignInfo#" ..
		    signs.Info .. tostring(#vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })) ..
		    "%#Comment#" .. " "
	else
		return ""
	end
end

-- status line
function status_line()
	return table.concat {
		"%#StatusLeft#",
		"%#String#",
		status_line_git_branch(),
		"%#Identifier#",
		" %y",
		"%#SpecialKey#",
		" %{&fileencoding?&fileencoding:&encoding}",
		" %{&fileformat}",
		status_line_diagnostics(),
		"%=",
		"%#Normal#",
		" %f",
		"%#Macro#",
		" %M",
		"%=",
		"%#TabLineSel#",
		-- "%-43(",
		" 0x%02B █",
		" %l/%L (%p%%) █",
		" %l:%c █",
		" time: %{strftime('%H:%M')} ",
		-- "%)"
	}
end

vim.opt.statusline = status_line() -- "%!luaeval('status_line()')"
local statusline = vim.api.nvim_create_augroup("Statusline", { clear = true })
vim.api.nvim_create_autocmd("CursorHold", {
	group = statusline,
	desc = "update statusline",
	pattern = "*",
	callback = function() vim.opt.statusline = status_line() end,
})
