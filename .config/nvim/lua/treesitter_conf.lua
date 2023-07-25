-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
	-- Add languages to be installed here that you want installed for treesitter
	ensure_installed = {
		'markdown',
		'markdown_inline',
		'latex',
		'bibtex',
		'html',
		'css',
		'c',
		'cpp',
		'python',
		'rust',
		'tsx',
		'typescript',
		'vim',
		'lua',
	},

	-- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
	auto_install = true,

	highlight = {
		enable = true,
		-- disable slow treesitter highlight for large files
		disable = function(lang, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,
	},
	indent = { enable = true, disable = { 'python' } },
	incremental_selection = { enable = true },
}
