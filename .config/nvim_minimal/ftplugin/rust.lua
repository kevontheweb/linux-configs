vim.lsp.start({
	name = 'rust-analyzer',
	cmd = { 'rust-analyzer' },
	root_dir = vim.fs.dirname(vim.fs.find({ 'Cargo.toml', 'main.rs' }, { upward = true })[1]),
})
