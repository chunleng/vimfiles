local codecompanion = require("codecompanion")
local codecompanion_config = require("codecompanion.config")
local codecompanion_model_list = require("mod.codecompanion.model_list")
local rules = require("codecompanion.interactions.chat.rules")

local function new_coder_chat(context)
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
				role = "system",
				content = [[Use deep logical thinking to aid the user on the task he is on. If needed, investigate the current working directory to gather the necessary information.
<guidelines>
- Try breaking down and understanding the task, ask user questions if the user requirements are unclear
- Avoid adding comments unless the code intent is ambiguous and the comment added should explain why the code is inserted, not how the code works
- Be short in your reply
- Think about ways to confirm changes, this includes, in the order of high to low preference:
  - Writing test and verify that the user's criteria is met
  - Running script and analyze result
  - Asking user to manually test and confirm value
</guidelines>]],
			},
			{
				role = "user",
				content = content,
			},
		},
		params = codecompanion_model_list.coding,
	})
	if chat then
		chat.tool_registry:add_group("agent", codecompanion_config.config.interactions.chat.tools)
		rules
			.new({ name = "default", files = codecompanion_config.rules["default"].files })
			:make({ chat = chat, force = true })
	end
	return chat
end

return {
	name = function()
		return "Coder"
	end,
	interaction = "chat",
	description = "Help user to get some coding done",
	opts = {
		rules = "default",
		intro_message = "This chat is now preset to help you complete task.",
	},
	prompts = {
		n = new_coder_chat,
		v = new_coder_chat,
	},
}
