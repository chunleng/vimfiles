local cc_constants = require("mod.ai.codecompanion.constants")
local cc_utils = require("mod.ai.codecompanion.utils")

return {
	name = function()
		return "Rename chat title"
	end,
	interaction = "chat",
	description = "Rename the current chat title",
	condition = function(context)
		return context.filetype == cc_constants.FILETYPE
	end,
	prompts = {
		n = function()
			cc_utils.rename_chat(vim.api.nvim_get_current_buf())
		end,
	},
}
