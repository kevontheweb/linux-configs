require('mason').setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
require('mason-lspconfig').setup({
    ensure_installed = {
        'pyright', 'rust_analyzer', 'html', 'emmet_ls', 'texlab', 'remark_ls',
        'clangd', 'bashls', 'tsserver'
    },
    automatic_installation = true
})

require'lspconfig'.pyright.setup {}
require'lspconfig'.clangd.setup {}
require'lspconfig'.html.setup {}
require'lspconfig'.emmet_ls.setup {}
require'lspconfig'.bashls.setup {}
require'lspconfig'.tsserver.setup {}
require'lspconfig'.rust_analyzer.setup {}

-- disable diagnostics globally

vim.lsp.handlers['textDocument/publishDiagnostics'] = function() end
