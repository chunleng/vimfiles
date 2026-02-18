local codecompanion = require("codecompanion")
local codecompanion_config = require("codecompanion.config")
local codecompanion_custom_config = require("mod.codecompanion.config")

return {
	name = function()
		return "Execution Buddy"
	end,
	interaction = "chat",
	description = "Help user to get something done",
	opts = {
		rules = "default",
		intro_message = "This chat is now preset to help you complete task.",
	},
	prompts = {
		n = function(context)
			local path = vim.fn.fnamemodify("wip.md", ":p")
			local wip_exist = vim.fn.filereadable(path) ~= 0
			local chat = codecompanion.chat({
				auto_submit = false,
				messages = {
					{
						role = "system",
						content = [[Use deep logical thinking to aid the user on the task he is on. Investigate the current working directory or go online to learn more about the situation. Be short in your reply
<guidelines>
- Use @{get_changed_files} to understand what is changed
- Perform execution until the user's request is achieved.
- If completion criteria is not clear, come up with a reasonable criteria and confirm with the user
- Don't ask permission to use tools unnecessarily
- If ./wip.md exists
	- Think deeply about the step's description and ask questions if there's ambiguity
	- Check off the task once you completed it
	- Never execute more than one step at once, unless the user specifies
</guidelines>]],
					},
					{
						role = "user",
						content = wip_exist
								and "I have attached the contents of `wip.md`, execute the next step, one step at a time"
							or "",
					},
				},
			})
			if chat then
				chat:change_adapter(codecompanion_custom_config.reasoning_model.name)
				chat:change_model({ model = codecompanion_custom_config.reasoning_model.model })
				chat.tool_registry:add_group("full_stack_dev", codecompanion_config.config.interactions.chat.tools)
				chat.tool_registry:add_group("web", codecompanion_config.config.interactions.chat.tools)
				if wip_exist then
					local bufnr = vim.fn.bufnr("wip.md")
					if bufnr == -1 then
						vim.api.nvim_win_call(context.winnr, function()
							vim.cmd("e " .. path)
						end)
						vim.api.bufnr = vim.fn.bufnr("wip.md")
					end

					local buffer = require("codecompanion.interactions.chat.slash_commands.builtin.buffer").new({
						Chat = chat,
						config = codecompanion_config.config.interactions.chat.slash_commands["buffer"],
						context = {},
						opts = {},
					})

					buffer:output({ bufnr = bufnr, name = path, path = path }, { silent = true })
				end
			end
			return chat
		end,
	},
}
