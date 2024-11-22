local gp = require("gp")
local M = {
	-- Note:
	-- * Temperature (0-1) adjust creativity with 0 (highly deterministic) and 1 (highly creative)
	-- * Top P (0-1) adjust next word use. e.g. 0.1 will only use 10% of the commonly used words for the next token
	models = {
		logic = { model = "gpt-4", temperature = 0.1, top_p = 0.2 },
		writing = { model = "gpt-4o", temperature = 0.8, top_p = 0.8 },
	},
	system_prompts = {
		programmer_code = "I want you to act as an expert programmer.\n\n"
			.. "Strictly avoid any commentary outside of the snippet response\n\n"
			.. "Start and end your answer with: ```",
		programmer_chat = "I want you to act as an expert programmer.",
		casual_writer = "I want you to act as a writer.\n\n" .. "Use a more casual and friendly tone in your writing.",
	},
	RangeType = { SELECTION = 0, ALL_BEFORE = 1 },
}

function M.send(template, table)
	local range = nil
	if table.range_type == M.RangeType.ALL_BEFORE then
		local current_line = vim.api.nvim_win_get_cursor(0)[1]
		range = current_line == 1 and {} or { range = 2, line1 = 1, line2 = current_line }
	else
		range = {
			range = 2,
			line1 = vim.api.nvim_buf_get_mark(0, "<")[1],
			line2 = vim.api.nvim_buf_get_mark(0, ">")[1],
		}
	end
	local target = table.target or gp.Target.append
	local prompt_text = table.has_prompt and "󱚤  ~" or nil
	local model = table.model or M.models.logic
	local system_prompt = table.system_prompt or M.system_prompts.programmer_code
	gp.Prompt(range, target, prompt_text, model, template, system_prompt)
end

function M.setup()
	gp.setup({ command_prompt_prefix_template = "󱚤  {{agent}} ~" })
end

return M
