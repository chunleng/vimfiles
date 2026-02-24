local codecompanion = require("codecompanion")
local codecompanion_config = require("codecompanion.config")
local codecompanion_custom_config = require("mod.codecompanion.config")

local system_content = [[Work with the user to produce the information needed to describe the Pull Request
<guidelines>
- Print out the content before attempting to submit or edit the pull request
- Be brief, explain what is the code suppose to achieve instead of focusing on the details
</guidelines>
<outputFormat>
Markdown format for both header. Please output with triple backticks
<outputComponent>
- `Title`: Title of the pull request
- `Description`: Details of the pull request
  - `Summary`: [Required] 1-2 liners to summarize the change and the impact
  - `Changes`: [Required] What was changed, why and how
  - `Tests`: [Required] Test that was performed
  - `Additional Resources`: [Optional] Might include related issues, documentation or any other resources to help reviewers understand the context
  - `Future Work`: [Optional] Note on work that was plan but not done to keep the scope clear
</outputComponent>
</outputFormat>]]

local function new_feature_writer_chat(context)
	local chat = codecompanion.chat({
		auto_submit = false,
		messages = {
			{
				role = "system",
				content = system_content,
			},
			{
				role = "user",
				content = "PR link: \n",
			},
		},
		params = {
			adapter = codecompanion_custom_config.reasoning_model.name,
			model = codecompanion_custom_config.reasoning_model.model,
		},
	})
	if chat then
		chat.tool_registry:add_group("github", codecompanion_config.config.interactions.chat.tools)
	end
	return chat
end

return {
	name = function()
		return "Pull Request"
	end,
	interaction = "chat",
	description = "Help user write pull request in the desire format",
	opts = {
		rules = "default",
		intro_message = "This chat is now preset to help you write pull request.",
		modes = { "n" },
	},
	prompts = {
		n = new_feature_writer_chat,
	},
}
