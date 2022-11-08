require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "pyright", "rust_analyzer", "html", "emmet_ls", "texlab", "remark_ls",
        "clangd", "bashls", "tsserver", "sumneko_lua"

    },
    automatic_installation = false
})

local cmp = require 'cmp'
cmp.setup {
    mapping = {
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-enter>'] = cmp.mapping.confirm {
            cmp.ConfirmBehavior.Insert,
            select = true
        },
        --[[
        ['<Tab>'] = function(fallback)
            if not cmp.select_next_item() then
                if vim.bo.buftype ~= 'prompt' and has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end
        end,

        ['<S-Tab>'] = function(fallback)
            if not cmp.select_prev_item() then
                if vim.bo.buftype ~= 'prompt' and has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end
        end
 ]]
        ["<Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,
        ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end
    },
    --[[  do it the 'vim' way
	  ['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
	  ['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    ['<C-y>'] = cmp.mapping.confirm{
		  cmp.ConfirmBehavior.Insert,
		  select = true,
	  },
--]]
    sources = {
        {name = 'nvim_lua'}, {name = 'nvim_lsp'}, {name = 'path'},
        {name = 'luasnip'}, {name = 'buffer', keyword_length = 4}
    },

    snippet = {
        -- expand = function(args) require("luasnip").lsp_expand(args.body) end
        expand = function(args)
            local line_num, col = unpack(vim.api.nvim_win_get_cursor(0))
            local line_text = vim.api.nvim_buf_get_lines(0, line_num - 1,
                                                         line_num, true)[1]
            local indent = string.match(line_text, '^%s*')
            local replace = vim.split(args.body, '\n', true)
            local surround = string.match(line_text, '%S.*') or ''
            local surround_end = surround:sub(col)

            replace[1] = surround:sub(0, col - 1) .. replace[1]
            replace[#replace] = replace[#replace] ..
                                    (#surround_end > 1 and ' ' or '') ..
                                    surround_end
            if indent ~= '' then
                for i, line in ipairs(replace) do
                    replace[i] = indent .. line
                end
            end

            vim.api.nvim_buf_set_lines(0, line_num - 1, line_num, true, replace)
        end
    },
    experimental = {native_menu = false, ghost_text_view = true}
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()

--[[
require('lspconfig')['pyright'].setup {on_attach = on_attach, flags = lsp_flags}

require'lspconfig'.sumneko_lua.setup {
    settings = {
        Lua = {
            runtime = {version = 'LuaJIT'},
            diagnostics = {globals = {'vim'}},
            workspace = {library = vim.api.nvim_get_runtime_file("", true)},
            telemetry = {enable = false}
        }
    }
}
 ]]
require'lspconfig'.pyright.setup {}
require'lspconfig'.sumneko_lua.setup {}
require'lspconfig'.html.setup {}
require'lspconfig'.emmet_ls.setup {}
require'lspconfig'.bashls.setup {}
require'lspconfig'.tsserver.setup {}
require'lspconfig'.rust_analyzer.setup {}
-- disable diagnostics globally
vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
