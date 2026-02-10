return {
	{
		dir = vim.fn.stdpath("config") .. "/lua/plugins/visuals",
		dependencies = {
			{ import = "plugins.visuals.nvim_tree" },
			{ import = "plugins.visuals.galaxyline" },
		},
	},
}
