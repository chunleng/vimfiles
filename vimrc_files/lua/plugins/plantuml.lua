return {
	{
		dir = vim.fn.stdpath("config") .. "/lua/plugins/plantuml",
		dependencies = {
			{ import = "plugins.plantuml.plantuml_syntax" },
		},
		ft = { "plantuml" },
	},
}
