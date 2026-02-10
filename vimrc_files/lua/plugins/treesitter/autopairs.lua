return {
	{
		-- https://github.com/windwp/nvim-autopairs
		-- https://github.com/nvim-treesitter/nvim-treesitter
		"windwp/nvim-autopairs",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			disable_in_macro = true,
			disable_in_visualblock = true,
			enable_afterquote = false,
			map_c_w = true,
			map_cr = false,
			check_ts = true,
		},
	},
}
