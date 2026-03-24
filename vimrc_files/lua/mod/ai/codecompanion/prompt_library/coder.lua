local codecompanion = require("codecompanion")
local codecompanion_config = require("codecompanion.config")
local models = require("mod.global_constants").codecompanion.models
local rules = require("codecompanion.interactions.chat.rules")

--- @param chat_type "helper"|"agent"
local function coder_chat_generator(chat_type)
	local system_content =
		[[Use deep logical thinking to aid the user. If needed, investigate the current working directory to gather the necessary information.
<guidelines>
%s
- Avoid adding comments unless the code intent is ambiguous and the comment added should explain why the code is inserted, not how the code works
- Be short in your reply
- Think about ways to confirm changes, this includes, in the order of high to low preference:
  - Writing test and verify that the user's criteria is met
  - Running script and analyze result
  - Asking user to manually test and confirm value
</guidelines>]]
	local chat_model = {}
	if chat_type == "helper" then
		system_content = system_content:format(
			"- Try breaking down and understanding the task, ask user questions if the user requirements are unclear"
		)
		chat_model = models.coding
	elseif chat_type == "agent" then
		system_content = system_content:format(
			[[- Try breaking down and understanding the task, make assumptions when user requirements are unclear
- Interrupt user as little as possible, tools such as @{ask_questions} and @{run_command} interrupts the user, so avoid using them unless absolute necessary ]]
		)
		chat_model = models.agentic
	end
	return function(context)
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
					content = system_content,
				},
				{
					role = "user",
					content = content,
				},
			},
			params = chat_model,
		})
		if chat then
			chat.tool_registry:add_group("agent", codecompanion_config.config.interactions.chat.tools)
			rules
				.new({ name = "default", files = codecompanion_config.rules["default"].files })
				:make({ chat = chat, force = true })
		end
		return chat
	end
end

return {
	coder = {
		name = function()
			return "Coder"
		end,
		interaction = "chat",
		description = "Help user to get some coding done",
		opts = {
			intro_message = "This chat is now preset to help you complete task.",
		},
		prompts = {
			n = coder_chat_generator("helper"),
			v = coder_chat_generator("helper"),
		},
	},
	coder_agent = {
		name = function()
			return "Coder Agent"
		end,
		interaction = "chat",
		description = "Complete coding task, with minimal interruption",
		opts = {
			intro_message = "This chat is now preset to help you complete task.",
		},
		prompts = {
			n = coder_chat_generator("agent"),
			v = coder_chat_generator("agent"),
		},
	},
}
