return {
	{
		dir = vim.fn.stdpath("config") .. "/lua/plugins/utils",
		dependencies = {
			{ import = "plugins.utils.undotree" },
			{ import = "plugins.utils.linediff" },
			{ import = "plugins.utils.localvimrc" },
		},
	},
}
