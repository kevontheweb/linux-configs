-- https://github.com/3BD-R/nvim/blob/main/lua/basic/term.lua
local te_buf = nil
local te_win_id = nil

local function openTerminal()
    if vim.fn.bufexists(te_buf) ~= 1 then
        vim.api.nvim_command(
            "au TermOpen * setlocal nonumber norelativenumber signcolumn=no")
        vim.api.nvim_command("sp | winc J | res 10 | te")
        te_win_id = vim.fn.win_getid()
        te_buf = vim.fn.bufnr('%')
    elseif vim.fn.win_gotoid(te_win_id) ~= 1 then
        vim.api.nvim_command("sb " .. te_buf .. "| winc J | res 10")
        te_win_id = vim.fn.win_getid()
    end
    vim.api.nvim_command("startinsert")
end

local function hideTerminal()
    if vim.fn.win_gotoid(te_win_id) == 1 then vim.api.nvim_command("hide") end
end

function ToggleTerminal()
    if vim.fn.win_gotoid(te_win_id) == 1 then
        hideTerminal()
    else
        openTerminal()
    end
end
