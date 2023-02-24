local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({
    --[[ on_attach = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
      vim.cmd("nnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.format()<CR>")

      -- format on save
      vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.format()")
    end

    if client.server_capabilities.documentRangeFormattingProvider then
      vim.cmd("xnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.range_formatting({})<CR>")
    end
  end, ]]
    sources = {
        null_ls.builtins.formatting.rustfmt.with({
            extra_args = {"--edition=2021"}
        }), null_ls.builtins.formatting.lua_format, -- luarocks install --server=https://luarocks.org/dev luaformatter
        null_ls.builtins.formatting.eslint, -- npm init @eslint/config
        null_ls.builtins.completion.spell,
        --[[         null_ls.builtins.diagnostics.pylint.with(
            { -- pip install pylint
                diagnostics_postprocess = function(diagnostic)
                    diagnostic.code = diagnostic.message_id
                end
            }), null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.black,
 ]]
        null_ls.builtins.formatting.prettierd,
        -- null_ls.builtins.diagnostics.clang_check, -- sudo dnf install clang-tools-extra
        null_ls.builtins.formatting.clang_format
    },
    -- format on save
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({group = augroup, buffer = bufnr})
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({bufnr = bufnr}, {async = true})
                end
            })
        end
    end
})

local prettier = require("prettier")
prettier.setup({
    bin = 'prettierd', -- or `'prettierd'` (v0.22+)
    filetypes = {
        "css", "graphql", "html", "javascript", "javascriptreact", "json",
        "less", "markdown", "scss", "typescript", "typescriptreact", "yaml"
    },
    cli_options = {
        arrow_parens = "always",
        bracket_spacing = true,
        bracket_same_line = false,
        embedded_language_formatting = "auto",
        end_of_line = "lf",
        html_whitespace_sensitivity = "css",
        -- jsx_bracket_same_line = false,
        jsx_single_quote = false,
        print_width = 100,
        prose_wrap = "preserve",
        quote_props = "as-needed",
        semi = true,
        single_attribute_per_line = false,
        single_quote = true,
        tab_width = 2,
        trailing_comma = "es5",
        use_tabs = false
    }
})
