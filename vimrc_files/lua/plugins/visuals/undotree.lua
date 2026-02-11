return {
	{
		-- https://github.com/jiaoshijie/undotree
		"jiaoshijie/undotree",
		dependencies = "nvim-lua/plenary.nvim",
		config = true,
		opts = {
			window = { winblend = 10 },
		},
		keys = {
			{
				"<c-s-u>",
				function()
					require("undotree").toggle()
				end,
				mode = { "n" },
			},
		},
	},
}
