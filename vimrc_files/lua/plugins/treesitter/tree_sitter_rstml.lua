return {
	{
		-- https://github.com/rayliwell/tree-sitter-rstml
		"rayliwell/tree-sitter-rstml",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		version = "*",
		build = ":TSInstall rust_with_rstml",
		config = true,
		ft = { "rust" },
	},
}
