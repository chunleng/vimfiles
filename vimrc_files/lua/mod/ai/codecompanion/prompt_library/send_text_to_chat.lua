local codecompanion = require("codecompanion")
local cc_chat = require("codecompanion.interactions.chat")

return {
	name = function()
		return "Send selection to chat"
	end,
	opts = { stop_context_insertion = true, modes = { "v" } },
	condition = function()
		local last_chat = cc_chat.last_chat()
		return last_chat and last_chat.ui:is_visible()
	end,
	interaction = "chat",
	description = "Create a new chat buffer to converse with an LLM",
	prompts = {
		v = function(context)
			local last_chat = cc_chat.last_chat()
			if last_chat then
				local text = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
				last_chat.builder:add_message({ content = "```" .. context.filetype .. "\n" .. text .. "\n```" }, {})
				vim.api.nvim_set_current_win(last_chat.ui.winnr)
			end
		end,
	},
}
