local M = {}

function M.setup()
	vim.o.foldmethod = "expr"
	vim.o.foldexpr = "nvim_treesitter#foldexpr()"
	vim.o.foldlevel = 99
	vim.o.foldlevelstart = 99

	require("nvim-treesitter.configs").setup({
		ensure_installed = {
			"bash",
			"cmake",
			"comment",
			"css",
			"csv",
			"diff",
			"dockerfile",
			"editorconfig",
			"git_config",
			"git_rebase",
			"gitattributes",
			"gitcommit",
			"gitignore",
			"glimmer_javascript",
			"glimmer_typescript",
			"html",
			"java",
			"javascript",
			"jsdoc",
			"json",
			"jsonc",
			"lua",
			"luadoc",
			"make",
			"markdown",
			"markdown_inline",
			"python",
			"regex",
			"ruby",
			"rust",
			"sql",
			"ssh_config",
			"terraform",
			"toml",
			"typescript",
			"vim",
			"xml",
			"yaml",
		},
		highlight = { enable = true },
		playground = { enable = true },
		endwise = { enable = true },
		incremental_selection = {
			enable = true,
			keymaps = {
				node_incremental = "<enter>",
				scope_incremental = "+",
				node_decremental = "-",
			},
		},
	})
end

return M
