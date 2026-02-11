return {
	{
		dir = vim.fn.stdpath("config") .. "/lua/plugins/ai",
		dependencies = {
			{ import = "plugins.ai.avante" },
			{ import = "plugins.ai.mcphub" },
		},
	},
}
