local function setup_stop_conceal()
	for _, lang in ipairs({
		"json",
		"markdown",
		"markdown_inline",
	}) do
		local queries = {}
		for _, file in ipairs(require("vim.treesitter.query").get_files(lang, "highlights")) do
			for _, line in ipairs(vim.fn.readfile(file)) do
				local line_sub = line:gsub([[%(#set! conceal_lines ""%)]], "")
				line_sub = line_sub:gsub([[%(#set! conceal ""%)]], "")
				table.insert(queries, line_sub)
			end
		end
		require("vim.treesitter.query").set(lang, "highlights", table.concat(queries, "\n"))
	end
end

local function setup()
	require("nvim-treesitter").install({
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
		"lua",
		"luadoc",
		"make",
		"markdown",
		"markdown_inline",
		"proto",
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
	})

	vim.api.nvim_create_autocmd("FileType", {
		callback = function()
			pcall(vim.treesitter.start)
		end,
	})

	vim.keymap.set("x", "<enter>", "an", { remap = true, desc = "Treesitter expand node" })
	vim.keymap.set("x", "+", "an", { remap = true, desc = "Treesitter expand node" })
	vim.keymap.set("x", "-", "in", { remap = true, desc = "Treesitter inner node" })

	setup_stop_conceal()
end

return {
	{
		dir = vim.fn.stdpath("config") .. "/lua/plugins/treesitter",
		dependencies = {
			{ import = "plugins.treesitter.treesitter" },
			{ import = "plugins.treesitter.autopairs" },
			{ import = "plugins.treesitter.tree_sitter_rstml" },
			{ import = "plugins.treesitter.ts_context_commentstring" },
			{ import = "plugins.treesitter.nvim_treesitter_context" },
		},
		config = setup,
	},
}
