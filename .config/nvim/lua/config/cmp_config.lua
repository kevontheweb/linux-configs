local cmp = require('cmp')
cmp.setup {
    mapping = {
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<enter>'] = cmp.mapping.confirm {
            cmp.ConfirmBehavior.Insert,
            select = true
        },
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end
    --[[  do it the 'vim' way
	['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
	['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
	['<C-y>'] = cmp.mapping.confirm{
		  cmp.ConfirmBehavior.Insert,
		  select = true,
	},
    --]]

    },
    sources = {
        {name = 'nvim_lua'}, {name = 'nvim_lsp'}, {name = 'path'},
        {name = 'calc'}, {name = 'buffer', keyword_length = 4},
        {name = 'cmd-line'}, {name = 'emoji'}, {name = 'spell'}
        --[[ {
            name = 'spell',
            option = {
                keep_all_entries = false,
                enable_in_context = function() return true end
            }
        } ]]
    },

    snippet = {
        -- expand = function(args) require('luasnip').lsp_expand(args.body) end
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
