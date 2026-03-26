local codecompanion_constant = require("mod.global_constants").codecompanion
local codecompanion = require("codecompanion")
local codecompanion_config = require("codecompanion.config")
local rules = require("codecompanion.interactions.chat.rules")

local system_content = [[Help the user with issue management tool
<guidelines>
- Follow the <issueFormat> if you are creating or editing an issue
- If needed, investigate the current directory to understand what issue
- Don't try to provide the solution, just provide the explanation of what needs to be achieved
- Apart from the content for the issue, reduce commentary such as summarizing your thoughts and actions
</guidelines>
<issueFormat>
<outputComponent>
- `Title`: title of the issue
- `Description`: Details of the issue, this should be in markdown format, it will contain different component depending on the type of issue.
  - If the issue is enhancement type
    - `Summary`: [Required] 1-2 liners to summarize the change and the impact
    - `Current State`: [Required] What's happening now without the enhancement
    - `Acceptance Criteria`: [Required] What is needed for this enhancement to be deemed as "completed"
    - `Additional Information`: [Optional] Other information that might not be directly related to the issue, but provide useful insights
  - If the issue is bug type
    - `Summary`: [Required] 1-2 liners to summarize the change and the impact
    - `Steps to Reproduce Error`: [Required] Step-by-step on how to reproduce the error, this can be command execution or manual walkthrough by the user
    - `Current Output`: [Required] Text output or screenshot of the error
    - `Expected Output`: [Required] What is expected to show instead of the `Current Output`
- Tags: If the issue management system has tags, add a list of values to describe the ticket. Currently, it allows the following:
  - bug: program not working as expected
  - enhancement: feature or ideas that improve the system
  - refactor: makes code more readable
  - good first issues: Relatively easy fixes
</outputComponent>
<issueManagementToolOutput>
`Title` component will match to title and `Description` will match to description of the issue
Each  (`Summary`, `Current State`, etc.) will be a level-3 header
</issueManagementToolOutput>
</issueFormat>]]

local function new_issue_chat(context)
	local messages = {
		{
			role = "system",
			content = system_content,
		},
	}
	if codecompanion_constant.issue.meta then
		table.insert(messages, {
			role = "system",
			content = "Use the following default information about the issue management tool, unless user specifies: "
				.. codecompanion_constant.issue.meta,
		})
	end
	table.insert(messages, {
		role = "user",
		content = "Issue link: \n",
	})
	local chat = codecompanion.chat({
		auto_submit = false,
		messages = messages,
	})
	if chat then
		for _, tool in ipairs(codecompanion_constant.issue.tools) do
			chat.tool_registry:add_single_tool(tool, codecompanion_config.config.interactions.chat.tools)
		end
		for _, group in ipairs(codecompanion_constant.issue.groups) do
			chat.tool_registry:add_group(group, codecompanion_config.config.interactions.chat.tools)
		end
		rules
			.new({ name = "default", files = codecompanion_config.rules["default"].files })
			:make({ chat = chat, force = true })
	end
	return chat
end

return {
	name = function()
		return "Issue"
	end,
	interaction = "chat",
	description = "Help user write issue in the desire format",
	opts = {
		rules = "default",
		intro_message = "This chat is now preset to help you write issue.",
		modes = { "n" },
	},
	prompts = {
		n = new_issue_chat,
	},
}
