-------------------------------------------------------------------------------
-- Tree sitter setup
-------------------------------------------------------------------------------
require('nvim-treesitter.configs').setup {
    ensure_installed = {
        "c", "python", "lua", "rust", "latex", "bash", "html", "css",
        "javascript", "json", "cpp", "yaml"
    },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        disable = function(lang, buf)
            local max_filesize = 400 * 1024 -- 400kb
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
        additional_vim_regex_highlighting = false
    }
}
