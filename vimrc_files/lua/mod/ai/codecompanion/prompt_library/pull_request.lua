local codecompanion_constant = require("mod.global_constants").codecompanion
local codecompanion = require("codecompanion")
local codecompanion_config = require("codecompanion.config")
local rules = require("codecompanion.interactions.chat.rules")

local system_content = [[Help the user with git management tool's pull request
<guidelines>
- Follow the <pullrequestFormat> if you are creating or editing an pull request
- Content should be brief, explaininig what is the code suppose to achieve instead of focusing on the details
- Apart from the content for the Pull Request, reduce commentary such as summarizing your thoughts and actions
</guidelines>
<pullrequestFormat>
<outputComponent>
- `Title`: Title of the pull request
- `Description`: Details of the pull request
  - `Summary`: [Required] 1-2 liners to summarize the change and the impact
  - `Changes`: [Required] What was changed, why and how
  - `Tests`: [Required] Test that was performed
  - `Additional Resources`: [Optional] Might include related issues, documentation or any other resources to help reviewers understand the context (Do not include the link of the current PR here)
  - `Future Work`: [Optional] Note on work that was plan but not done to keep the scope clear
</outputComponent>
<chatOutput>
Please output reply as Markdown codeblocks. as such:
```
## Title

<Title goes here>

## Description

### Summary

<Summary>

<!-- Do the same as Summary for other components as well, `Optional` components can be left out fully -->
```
<chatOutput>
<gitManagementToolOutput>
`Title` component will match to title and `Description` will match to description of the pull request
Each subcomponent of the `Description` component (i.e. `Summary`, `Changes`, etc.) will be a level-3 header
</gitMangementToolOutput>
</outputFormat>]]

local function new_pr_chat(context)
	local messages = {
		{
			role = "system",
			content = system_content,
		},
	}
	if codecompanion_constant.git.meta then
		table.insert(messages, {
			role = "system",
			content = "Use the following default information about the git management tool, unless user specifies: "
				.. codecompanion_constant.git.meta,
		})
	end
	table.insert(messages, {
		role = "user",
		content = "PR link: \n",
	})
	local chat = codecompanion.chat({
		auto_submit = false,
		messages = messages,
	})
	if chat then
		for _, tool in ipairs(codecompanion_constant.git.tools) do
			chat.tool_registry:add_single_tool(tool, codecompanion_config.config.interactions.chat.tools)
		end
		for _, group in ipairs(codecompanion_constant.git.groups) do
			chat.tool_registry:add_group(group, codecompanion_config.config.interactions.chat.tools)
		end
		chat.tool_registry:add_group("git", codecompanion_config.config.interactions.chat.tools)
		rules
			.new({ name = "default", files = codecompanion_config.rules["default"].files })
			:make({ chat = chat, force = true })
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
		n = new_pr_chat,
	},
}
