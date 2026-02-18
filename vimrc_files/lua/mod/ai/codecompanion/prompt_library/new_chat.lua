local codecompanion = require("codecompanion")

return {
	name = function()
		return "New chat"
	end,
	interaction = "chat",
	description = "Create a new chat buffer to converse with an LLM",
	prompts = {
		n = function()
			return codecompanion.chat()
		end,
		v = {
			{ role = "user" },
		},
	},
}
