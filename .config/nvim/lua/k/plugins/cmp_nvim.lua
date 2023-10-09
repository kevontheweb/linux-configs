-- [[ nvim-cmp setup (Autocompletion) ]]
local cmp = require 'cmp'
local luasnip = require 'luasnip'
luasnip.config.setup {}

cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert {
		['<C-u>'] = cmp.mapping.scroll_docs(-4), -- don't think these work tbh
		['<C-d>'] = cmp.mapping.scroll_docs(4), -- don't think these work tbh
		['<C-Space>'] = cmp.mapping.complete {}, -- trigger completion popup
		['<CR>'] = cmp.mapping.confirm { -- confirm lsp completions with enter (currently using tab for completion of codeium AI suggestions)
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},

		--[[ ['<Tab>'] = cmp.mapping.confirm { -- confirm lsp completions with enter (currently using tab for )
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}, ]]

		['<C-n>'] = cmp.mapping(function(fallback) -- next
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' }),

		['<C-p>'] = cmp.mapping(function(fallback) -- previous
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
	},
	sources = {
		{ name = 'org' },
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'buffer' },
		-- { name = 'cmdline' },
		{ name = 'path' },
		{
			name = 'spell',
			option = {
				keep_all_entries = false,
				enable_in_context = function()
					return require('cmp.config.context').in_treesitter_capture('spell')
				end,
			}
		},
	},
}

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})
