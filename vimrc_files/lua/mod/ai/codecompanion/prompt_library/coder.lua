local codecompanion = require("codecompanion")
local codecompanion_config = require("codecompanion.config")
local codecompanion_model_list = require("mod.codecompanion.model_list")
local rules = require("codecompanion.interactions.chat.rules")

local function new_coder_chat(context)
	local path = vim.fn.fnamemodify(".vim/wip.md", ":p")
	local wip_exist = vim.fn.filereadable(path) ~= 0
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
				content = [[Use deep logical thinking to aid the user on the task he is on. Investigate the current working directory or go online to learn more about the situation.
<guidelines>
- Try breaking down and understanding the task, ask user questions if the user requirements are unclear
- Avoid adding comments unless the code intent is ambiguous and the comment added should explain why the code is inserted, not how the code works
- Be short in your reply
- Think about ways to confirm changes, this includes, in the order of high to low preference:
  - Writing test and verify that the user's criteria is met
  - Running script and analyze result
  - Asking user to manually test and confirm value]]
					.. (wip_exist and [[
- If .vim/wip.md exists
  - Try and match user's request to the list and check off the task once you completed it]] or "")
					.. [[
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
		if wip_exist then
			local bufnr = vim.fn.bufnr(".vim/wip.md")
			if bufnr == -1 then
				vim.api.nvim_win_call(context.winnr, function()
					vim.cmd("e " .. path)
				end)
				vim.api.bufnr = vim.fn.bufnr(".vim/wip.md")
			end

			local buffer = require("codecompanion.interactions.chat.slash_commands.builtin.buffer").new({
				Chat = chat,
				config = codecompanion_config.config.interactions.chat.slash_commands["buffer"],
				context = {},
				opts = {},
			})

			buffer:output({ bufnr = bufnr, name = path, path = path }, { silent = true })
		end
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
