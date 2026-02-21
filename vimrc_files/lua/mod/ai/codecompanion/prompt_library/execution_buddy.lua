local codecompanion = require("codecompanion")
local codecompanion_config = require("codecompanion.config")
local codecompanion_custom_config = require("mod.codecompanion.config")

local function new_execution_buddy_chat(context)
	local path = vim.fn.fnamemodify("wip.md", ":p")
	local wip_exist = vim.fn.filereadable(path) ~= 0
	local content = ""

	if wip_exist then
		content = content .. "I have attached the contents of `wip.md`, execute the next step"
	end
	if context.mode == "v" or context.mode == "V" then
		content = "Execute the following\n```"
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
				content = [[Use deep logical thinking to aid the user on the task he is on. Investigate the current working directory or go online to learn more about the situation. Be short in your reply
<guidelines>
- Perform execution until the user's request is achieved, ensure achievement through confirmation using tools (preferably) or leaving a message on how the user can confirm
- If completion criteria is not clear, come up with a reasonable criteria and confirm with the user
- If there are few actions you can take to resolve the current problem, choose the most appropriate one without user's intervention
- When user ask for changes, do not dismiss the request
- If it's coding project
  - Verify the code that you wrote is working]]
					.. (wip_exist and [[
- If ./wip.md exists
	- Use @{get_changed_files} to understand what is already changed locally before proceeding
	- Think deeply about the step's description and ask questions if there's ambiguity
	- Check off the task once you completed it, after you check off any task, summarize what was done and DO NOT execute the next step. Ask user to confirm if the task is done correctly]] or "")
					.. [[
</guidelines>]],
			},
			{
				role = "user",
				content = content,
			},
		},
		params = {
			adapter = codecompanion_custom_config.reasoning_model.name,
			model = codecompanion_custom_config.reasoning_model.model,
		},
	})
	if chat then
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
end

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
		n = new_execution_buddy_chat,
		v = new_execution_buddy_chat,
	},
}
