local codecompanion = require("codecompanion")
local codecompanion_config = require("codecompanion.config")

return {
	name = function()
		return "Research"
	end,
	interaction = "chat",
	description = "Research and learn about topic",
	opts = {
		rules = "default",
		intro_message = "This chat is now preset to help you research on any topic",
		modes = { "n" },
	},
	prompts = {
		n = function()
			local chat = codecompanion.chat({
				auto_submit = false,
				messages = {
					{
						role = "system",
						content = [[The user will post question or topic of interest
Your job is to search online and gather information for the user
<guidelines>
- Think about how to change user's query into effective @{web_search}. If needed, make more @{web_search} to get to the result
- Follow through links on the result if you think it can be helpful for the research
- Summary of research should capture the essence of the research and you don't have to put too many details. The user can query later if needed
- Use <outputFormat> when formatting the results of search, if not, you don't have to stick to the format
</guidelines>
<example>
<userQuery>How to stay healthy?</userQuery>
<outputFormat>
### Sources

#### 1. Search Query: How to stay healthy

a. <source>
b. <another source>
..

#### 2. Search Query: How to fall sick less frequently

a. <sources>
..

### Summary

(Provide result with source number [1a] to show where the sources came from. For `[1a]`, `1` is the query used and `a` is the source from that search)
</outputFormat><example>]],
					},
					{
						role = "user",
						content = "What is...",
					},
				},
			})
			if chat then
				chat.tool_registry:add_group("web", codecompanion_config.config.interactions.chat.tools)
			end
			return chat
		end,
	},
}
