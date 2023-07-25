local util = require "formatter.util"

require("formatter").setup {
	filetype = {
		lua = {
			require("formatter.filetypes.lua").stylua,
		},
		python = {
			require('formatter.filetypes.lua').black,
		},
		markdown = {
			require('formatter.filetypes.markdown').prettier,
		},
		["*"] = {
			require("formatter.filetypes.any").remove_trailing_whitespace
		}
	}
}
