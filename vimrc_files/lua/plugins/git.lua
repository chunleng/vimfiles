return {
	{
		dir = vim.fn.stdpath("config") .. "/lua/plugins/git",
		dependencies = {
			{ import = "plugins.git.fugitive" },
			{ import = "plugins.git.gitlinker" },
			{ import = "plugins.git.gitsigns" },
		},
	},
}
