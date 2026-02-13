return {
	{
		dir = vim.fn.stdpath("config") .. "/lua/plugins/ai",
		dependencies = {
			{ import = "plugins.ai.codecompanion" },
			{ import = "plugins.ai.mcphub" },
			{ import = "plugins.ai.copilot" },
		},
	},
}
