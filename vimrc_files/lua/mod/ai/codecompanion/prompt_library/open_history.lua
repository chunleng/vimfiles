return {
	name = function()
		return "Open History"
	end,
	interaction = "chat",
	description = "Open past conversation",
	prompts = {
		n = function()
			vim.cmd("CodeCompanionHistory")
		end,
		v = function()
			vim.cmd("CodeCompanionHistory")
		end,
	},
}
