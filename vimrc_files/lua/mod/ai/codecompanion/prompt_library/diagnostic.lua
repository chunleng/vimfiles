local codecompanion = require("codecompanion")
local codecompanion_config = require("codecompanion.config")

return {
	name = function()
		return "Diagnostic"
	end,
	interaction = "chat",
	description = "Get the current error in the LSP and analyze the error",
	opts = {
		rules = "default",
		intro_message = "This chat is now preset to help you diagnose LSP errors.",
	},
	prompts = {
		n = function(context)
			local chat = codecompanion.chat({
				auto_submit = false,
				messages = {
					{
						role = "system",
						content = [[You will be provided with the LSP diagnostic coming from the user's IDE
Your task is to focus on the error level diagnostics only
<guidelines>
- Research on the code to understand where's the cause of the error
</guidelines>
<outputFormat>
- Format in markdown with the following information per error:
  - Filename with line number: relative/to/path:<line_number>
  - Short description of what is happening and the root cause
  - Short description as to how to resolve the error
- If errors have similar root cause, you can combine them
<example>
**source**: src/main.rs:2
**cause**: `foo.user` caused error because `user` is not a field on type `Option<_>`.
**possible solution**: use `foo.unwrap().user` instead.
</example>
</outputFormat>]],
					},
					{
						role = "user",
						content = "#{lsp}\nSummarize the error for me",
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
