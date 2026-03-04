return {
	{
		dir = vim.fn.stdpath("config") .. "/lua/plugins/utils",
		dependencies = {
			{ import = "plugins.utils.localvimrc" },
			{ import = "plugins.utils.projectionist" },
		},
	},
}
