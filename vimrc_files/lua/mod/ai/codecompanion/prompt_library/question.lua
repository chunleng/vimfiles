local codecompanion = require("codecompanion")
local codecompanion_config = require("codecompanion.config")

return {
	name = function()
		return "Question"
	end,
	interaction = "chat",
	description = "Question about selected line",
	opts = {
		rules = "default",
		intro_message = "This chat is now preset to help you answer questions you have in this directory",
		modes = { "v" },
	},
	prompts = {
		v = function(context)
			-- NOTE: This doesn't work unless the following PR is merged: https://github.com/olimorris/codecompanion.nvim/pull/2762
			local text = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
			local chat = codecompanion.chat({
				auto_submit = false,
				messages = {
					{
						role = "system",
						content = [[The user will ask a question and also give you an extract from a document of which he would like to ask about
Answer the question in the way best suited for the directory that the user is in
Search through the directory to understand more about the line in question
Or, perform a web search if needed
<guidelines>
- Be brief in answering, don't try to explain about how you came up with the answer
- Don't explain literally, for example:
  - When shown some programming code, you might need to dive deeper if code is ambiguous.
  - When looking at paragraph from a text, you might want to check related text to understand more.
</guidelines>]],
					},
					{
						role = "user",
						content = "What does the following line(s) do?\n\n```"
							.. context.filetype
							.. "\n"
							.. text
							.. "\n```",
					},
				},
			})
			if chat then
				local file = require("codecompanion.interactions.chat.slash_commands.builtin.file").new({
					Chat = chat,
					config = {},
					context = {},
					opts = {},
				})
				file:output({ path = context.filename }, { silent = true })
				chat.tool_registry:add_group("web", codecompanion_config.config.interactions.chat.tools)
			end
			return chat
		end,
	},
}
