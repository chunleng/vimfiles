local gp = require("gp")
-- Note:
-- * Temperature (0-1) adjust creativity with 0 (highly deterministic) and 1 (highly creative)
-- * Top P (0-1) adjust next word use. e.g. 0.1 will only use 10% of the commonly used words for the next token
local models = {
	logic = { model = "o1-mini", temperature = 0.1, top_p = 0.2 },
	writing = { model = "gpt-4o-mini", temperature = 0.8, top_p = 0.8 },
}

local M = {
	agent = {
		programmer_code = {
			system_prompt = "I want you to act as an expert programmer.\n"
				.. "Please think through step-by-step and solve the problem with clear and add the smallest amount of "
				.. "changes to the code that can achieve the objective provided in the instruction, you can skip all "
				.. "the explanations using print line or logging.\n"
				.. "STRICTLY NO COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE\n"
				.. "START AND END YOUR ANSWER WITH SNIPPET: ```",
			model = models.logic,
			provider = "openai",
		},
		programmer_chat = {
			system_prompt = "I want you to act as an expert programmer. Please think through step-by-step.",
			model = models.writing,
			provider = "openai",
		},
		casual_writer = {
			system_prompt = "I want you to reply in a casual style, as if you are talking to someone familiar.",
			model = models.writing,
			provider = "openai",
		},
		technical_writer = {
			system_prompt = "I want you to phrase the reply in a way that is suitable for code documentation or software design document.",
			model = models.writing,
			provider = "openai",
		},
	},
	RangeType = { SELECTION = 0, ALL_BEFORE = 1 },
}

function M.send(agent, table)
	local range = nil
	if table.range_type == M.RangeType.ALL_BEFORE then
		local current_line = vim.api.nvim_win_get_cursor(0)[1]
		range = { range = 2, line1 = 1, line2 = current_line }
	else
		range = {
			range = 2,
			line1 = vim.api.nvim_buf_get_mark(0, "<")[1],
			line2 = vim.api.nvim_buf_get_mark(0, ">")[1],
		}
	end
	local target = table.target or gp.Target.append
	local prompt_text = nil
	if table.template == nil then
		prompt_text = "󱚤  ~"
	end
	local template = table.template or "{{command}}"
	if target == gp.Target.append then
		template = "I have the following from {{filename}}:"
			.. "\n\n```{{filetype}}\n{{selection}}\n```\n\n"
			.. template
			.. "\n\nRespond exclusively with the snippet that should be appended after the selection above."
	elseif target == gp.Target.rewrite then
		template = "I have the following from {{filename}}:"
			.. "\n\n```{{filetype}}\n{{selection}}\n```\n\n"
			.. template
			.. "\n\nRespond exclusively with the snippet that should replace the selection above."
	else
		template = "I have the following from {{filename}}:"
			.. "\n\n```{{filetype}}\n{{selection}}\n```\n\n"
			.. template
	end
	gp.Prompt(range, target, agent, template, prompt_text)
end

function M.setup()
	gp.setup({ command_prompt_prefix_template = "󱚤  {{agent}} ~" })
end

return M
