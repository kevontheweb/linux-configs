-------------------------------------------------------------------------------
-- Statusline
-------------------------------------------------------------------------------
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

function git_branch()
    return os.capture("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d \'\'")
end

function status_line()
	return table.concat {
		"%#StatusLeft#",
                "%#Keyword#",
                git_branch(),
                "%#Keyword#",
                " %F",
                " %2*%m%*",
                "%#LineNr#",
                "%=",
		"%#StatusRight#",
                "0x%04B",
                "%#Keyword#",
                " %y",
                "%#SpecialKey#",
                " %{&fileencoding?&fileencoding:&encoding}",
                " [%{&fileformat}]",
                " %p%%",
                " %l:%c",
                " [%{strftime('%H:%M')}]"
	}
end
vim.opt.statusline = "%!luaeval('status_line()')"
-------------------------------------------------------------------------------


