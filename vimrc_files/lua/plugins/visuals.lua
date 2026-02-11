return {
	{
		dir = vim.fn.stdpath("config") .. "/lua/plugins/visuals",
		dependencies = {
			{ import = "plugins.visuals.undotree" },
			{ import = "plugins.visuals.linediff" },
			{ import = "plugins.visuals.trailing_whitespace" },
			{ import = "plugins.visuals.scrollbar" },
			{ import = "plugins.visuals.ufo" },
			{ import = "plugins.visuals.indentline" },
			{ import = "plugins.visuals.sleuth" },
			{ import = "plugins.visuals.colorizer" },
		},
	},
}
