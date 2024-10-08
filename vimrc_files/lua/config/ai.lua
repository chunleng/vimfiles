local RangeType = { SELECTION = 0, ALL_BEFORE = 1 }
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
}

local function send(template, table)
	local range = nil
	if table.range_type == RangeType.ALL_BEFORE then
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

	local utils = require("common-utils")
	utils.keymap("n", "<c-space>", function()
		vim.ui.select({
			"Programmer: Complete Code",
			"Casual Writer: Write Article",
			"Technical Writer: Write technical documents",
		}, {}, function(choice)
			if choice == "Programmer: Complete Code" then
				send(
					"Having following from {{filename}}:\n\n"
						.. "```{{filetype}}\n{{selection}}\n```\n\n"
						.. "Please reply with only the code added.\n\n"
						.. "Please continue the code with the following instruction: {{command}}",
					{ has_prompt = true, range_type = RangeType.ALL_BEFORE }
				)
			elseif choice == "Casual Writer: Write Article" then
				send(
					"Having the following start:\n\n"
						.. "```\n{{selection}}\n```\n\n"
						.. "Please continue the writing with the following instruction in a casual style: {{command}}",
					{ has_prompt = true, range_type = RangeType.ALL_BEFORE, model = M.models.writing }
				)
			elseif choice == "Technical Writer: Write technical documents" then
				send(
					"You are a technical writer. Having the following start:\n\n"
						.. "```\n{{selection}}\n```\n\n"
						.. "Please continue the writing with the following instruction: {{command}}",
					{ has_prompt = true, range_type = RangeType.ALL_BEFORE, model = M.models.writing }
				)
			end
		end)
	end, { silent = false })
	utils.keymap("v", "<c-space>", function()
		vim.ui.select({
			"Programmer: Refine Code",
			"Programmer: Ask",
			"Programmer: Summarize Code",
			"Programmer: Code Review",
			"Programmer: Write Unit Test",
			"Casual Writer: Refine Writing",
			"Technical Writer: Refine Writing",
		}, {}, function(choice)
			if choice == "Programmer: Refine Code" then
				send(
					"Having following from {{filename}}:\n\n"
						.. "```{{filetype}}\n{{selection}}\n```\n\n"
						.. "Please rewrite the code with the following instruction:\n\n{{command}}",
					{ has_prompt = true, target = gp.Target.rewrite }
				)
			elseif choice == "Programmer: Ask" then
				send(
					"Having following from {{filename}}:\n\n" .. "```{{filetype}}\n{{selection}}\n```\n\n{{command}}",
					{
						has_prompt = true,
						target = gp.Target.vnew("markdown"),
						system_prompt = M.system_prompts.programmer_chat,
					}
				)
			elseif choice == "Programmer: Write Unit Test" then
				send(
					"Having following from {{filename}}:\n\n"
						.. "```{{filetype}}\n{{selection}}\n```\n\n"
						.. "Please write unit test to test if the code is working",
					{ target = gp.Target.enew }
				)
			elseif choice == "Programmer: Summarize Code" then
				send(
					"Having following from {{filename}}:\n\n"
						.. "```{{filetype}}\n{{selection}}\n```\n\n"
						.. "Please understand what the code is trying to do and "
						.. "respond with a summary the core logic in steps but as short as possible.\n\n"
						.. "It's okay to drop steps which are not relevant to understand the logic",
					{
						target = gp.Target.vnew("markdown"),
						system_prompt = M.system_prompts.programmer_chat,
					}
				)
			elseif choice == "Programmer: Code Review" then
				send(
					"Having following from {{filename}}:\n\n"
						.. "```{{filetype}}\n{{selection}}\n```\n\n"
						.. "Please analyze for code smells and suggest improvements.",
					{
						target = gp.Target.vnew("markdown"),
						system_prompt = M.system_prompts.programmer_chat,
					}
				)
			elseif choice == "Casual Writer: Refine Writing" then
				send(
					"Having the following:\n\n"
						.. "```\n{{selection}}\n```\n\n"
						.. "Please rewrite it with the following instruction in a casual style: {{command}}",
					{ has_prompt = true, target = gp.Target.rewrite, system_prompt = M.system_prompts.casual_writer }
				)
			elseif choice == "Technical Writer: Refine Writing" then
				send(
					"You are a technical writer. Having the following:\n\n"
						.. "```\n{{selection}}\n```\n\n"
						.. "Please rewrite it with the following instruction: {{command}}",
					{ has_prompt = true, target = gp.Target.rewrite, system_prompt = M.system_prompts.casual_writer }
				)
			end
		end)
	end)
end

return M
