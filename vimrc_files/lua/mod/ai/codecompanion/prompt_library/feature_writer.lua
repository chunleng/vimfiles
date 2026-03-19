local codecompanion = require("codecompanion")
local codecompanion_config = require("codecompanion.config")
local codecompanion_custom_config = require("mod.codecompanion.config")

local system_content = [[Use deep logical thinking to produce a feature write-up
Investigate the current working directory or go online to learn more about the situation
<flow>
1. Elicit feature request - ask user clarifying questions if needed
2. Breakdown into subfeatures where necessary
3. Find implementation approach for each subfeature based on existing code - ask user about specific library/framework if unclear, but include only the core idea
**Confirm with user after each step before proceeding**
</flow>
<guidelines>
- Don't include schedule planning or priorities
- Don't include current implementation status, the document describes feature and not track whether the feature is implemented or not
- Don't go into implementation details, or details about code, code structure, test and CI/CD of the feature
- When updating existing document, think carefully and make only relevant changes. Don't attempt to replace current wording unnecessarily
</guidelines>
<outputFormat>
The feature write-up is a markdown file
Headers and subheaders should not be numbered
<outputComponent>
- Overview: Required. Summary of the document
- Core Implementation Library/Framework/Tool: Required.
  - Consists of the core library/framework/tool used in this feature implementation
  - Create a table with columns "Library/Framework/Tool" and "Purpose"
  - The major version of the library/framework/tool should be listed, if available
- Feature Components: Required. Description of the feature and explanation on how it can be used
- Challenges and Considerations: Optional. Any possible problems that could happen during the implementations, with possible solution if any
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
				content = "Output to ./docs/features/",
			},
		},
		params = {
			adapter = codecompanion_custom_config.reasoning_model.name,
			model = codecompanion_custom_config.reasoning_model.model,
		},
	})
	if chat then
		chat.tool_registry:add_group("files", codecompanion_config.config.interactions.chat.tools)
		chat.tool_registry:add_group("web", codecompanion_config.config.interactions.chat.tools)
	end
	return chat
end

return {
	name = function()
		return "Feature Writer"
	end,
	interaction = "chat",
	description = "Help user write feature",
	opts = {
		rules = "default",
		intro_message = "This chat is now preset to help you write features.",
		modes = { "n" },
	},
	prompts = {
		n = new_feature_writer_chat,
	},
}
