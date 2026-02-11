return {
	{
		dir = vim.fn.stdpath("config") .. "/lua/plugins/ui",
		dependencies = {
			{ import = "plugins.ui.bufferline" },
			{ import = "plugins.ui.nvim_tree" },
			{ import = "plugins.ui.galaxyline" },
			{ import = "plugins.ui.aerial" },
			{ import = "plugins.ui.scope" },
			{ import = "plugins.ui.dressing" },
			{ import = "plugins.ui.fzf_lua" },
		},
	},
}
