local codecompanion = require("codecompanion")
local codecompanion_config = require("codecompanion.config")

local function new_chat_with_buffer(context)
	local content = ""
	if context.mode == "v" or context.mode == "V" then
		content = "```"
			.. context.filetype
			.. "\n"
			.. require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
			.. "\n```"
	end
	local chat = codecompanion.chat({
		auto_submit = false,
		messages = {
			{
				role = "user",
				content = content,
			},
		},
	})
	if chat then
		local buffer = require("codecompanion.interactions.chat.slash_commands.builtin.buffer").new({
			Chat = chat,
			config = codecompanion_config.config.interactions.chat.slash_commands["buffer"],
			context = {},
			opts = {},
		})

		buffer:output({ bufnr = context.bufnr, path = context.filename }, { silent = true })
	end

	return chat
end

return {
	name = function()
		return "New chat with buffer"
	end,
	interaction = "chat",
	description = "Create a new chat, attaching the current buffer, to converse with an LLM",
	condition = function(context)
		if context.filetype == "codecompanion" then
			return false
		else
			return true
		end
	end,
	prompts = {
		n = new_chat_with_buffer,
		v = new_chat_with_buffer,
	},
}
