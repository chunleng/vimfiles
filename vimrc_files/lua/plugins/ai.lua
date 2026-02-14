return {
	{
		dir = vim.fn.stdpath("config") .. "/lua/plugins/ai",
		dependencies = {
			{ import = "plugins.ai.codecompanion" },
			{ import = "plugins.ai.mcphub" },
			-- Suspect this is making some weird actifact and therefore I will turn it on when I need to login to
			-- copilot
			-- { import = "plugins.ai.copilot" },
		},
	},
}
