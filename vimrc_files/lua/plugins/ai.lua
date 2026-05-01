return {
	{
		dir = vim.fn.stdpath("config") .. "/lua/plugins/ai",
		dependencies = {
			{ import = "plugins.ai.tenon" },
			{ import = "plugins.ai.mcphub" },
		},
	},
}
