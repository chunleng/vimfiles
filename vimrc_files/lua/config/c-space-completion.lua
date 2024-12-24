local M = {}

local utils = require("common-utils")
local ai = require("config.ai")
local gp = require("gp")
local neogen = require("neogen")

local function insertion_actions()
	utils.keymap({ "n", "i" }, "<c-space>", function()
		utils.action_menu({
			{
				choice = "Docstring: function",
				func = function()
					neogen.generate({ type = "func" })
				end,
				ft = utils.programming_languages,
			},
			{
				choice = "Docstring: class",
				func = function()
					neogen.generate({ type = "class" })
				end,
				ft = utils.programming_languages,
			},
			{
				choice = "Docstring: file",
				func = function()
					neogen.generate({ type = "file" })
				end,
				ft = utils.programming_languages,
			},
			{
				choice = "Add ZK link",
				func = function()
					vim.cmd("ZkInsertLink")
				end,
				ft = { "markdown" },
			},
			{
				choice = "Programmer: Complete Code",
				func = function()
					ai.send(
						"Having following from {{filename}}:\n\n"
							.. "```{{filetype}}\n{{selection}}\n```\n\n"
							.. "Please reply with only the code added.\n\n"
							.. "Please continue the code with the following instruction: {{command}}",
						{ has_prompt = true, range_type = ai.RangeType.ALL_BEFORE }
					)
				end,
				ft = utils.programming_languages,
			},
			{
				choice = "Casual Writer: Write Article",
				func = function()
					ai.send(
						"Having the following start:\n\n"
							.. "```\n{{selection}}\n```\n\n"
							.. "Please continue the writing with the following instruction in a casual style: {{command}}",
						{ has_prompt = true, range_type = ai.RangeType.ALL_BEFORE, model = ai.models.writing }
					)
				end,
			},
			{
				choice = "Technical Writer: Write technical documents",
				func = function()
					ai.send(
						"You are a technical writer. Having the following start:\n\n"
							.. "```\n{{selection}}\n```\n\n"
							.. "Please continue the writing with the following instruction: {{command}}",
						{ has_prompt = true, range_type = ai.RangeType.ALL_BEFORE, model = ai.models.writing }
					)
				end,
			},
		})
	end, { silent = false })
end

local function selection_actions()
	utils.keymap("v", "<c-space>", function()
		utils.action_menu({
			{
				choice = "Add ZK link at selection",
				func = function()
					vim.cmd("'<,'>ZkInsertLinkAtSelection")
				end,
				ft = { "markdown" },
			},
			{
				choice = "Programmer: Refine Code",
				func = function()
					ai.send(
						"Having following from {{filename}}:\n\n"
							.. "```{{filetype}}\n{{selection}}\n```\n\n"
							.. "Please rewrite the code with the following instruction:\n\n{{command}}",
						{ has_prompt = true, target = gp.Target.rewrite }
					)
				end,
				ft = utils.programming_languages,
			},
			{
				choice = "Programmer: Ask",
				func = function()
					ai.send(
						"Having following from {{filename}}:\n\n"
							.. "```{{filetype}}\n{{selection}}\n```\n\n{{command}}",
						{
							has_prompt = true,
							target = gp.Target.vnew("markdown"),
							system_prompt = ai.system_prompts.programmer_chat,
						}
					)
				end,
			},
			{
				choice = "Programmer: Summarize Code",
				func = function()
					ai.send(
						"Having following from {{filename}}:\n\n"
							.. "```{{filetype}}\n{{selection}}\n```\n\n"
							.. "Please understand what the code is trying to do and "
							.. "respond with a summary the core logic in steps but as short as possible.\n\n"
							.. "It's okay to drop steps which are not relevant to understand the logic",
						{
							target = gp.Target.vnew("markdown"),
							system_prompt = ai.system_prompts.programmer_chat,
						}
					)
				end,
				ft = utils.programming_languages,
			},
			{
				choice = "Programmer: Code Review",
				func = function()
					ai.send(
						"Having following from {{filename}}:\n\n"
							.. "```{{filetype}}\n{{selection}}\n```\n\n"
							.. "Please analyze for code smells and suggest improvements.",
						{
							target = gp.Target.vnew("markdown"),
							system_prompt = ai.system_prompts.programmer_chat,
						}
					)
				end,
				ft = utils.programming_languages,
			},
			{
				choice = "Programmer: Write Unit Test",
				func = function()
					ai.send(
						"Having following from {{filename}}:\n\n"
							.. "```{{filetype}}\n{{selection}}\n```\n\n"
							.. "Please write unit test to test if the code is working",
						{ target = gp.Target.enew }
					)
				end,
				ft = utils.programming_languages,
			},
			{
				choice = "Casual Writer: Refine Writing",
				func = function()
					ai.send(
						"Having the following:\n\n"
							.. "```\n{{selection}}\n```\n\n"
							.. "Please rewrite it with the following instruction in a casual style: {{command}}",
						{
							has_prompt = true,
							target = gp.Target.rewrite,
							system_prompt = ai.system_prompts.casual_writer,
						}
					)
				end,
			},
			{
				choice = "Technical Writer: Refine Writing",
				func = function()
					ai.send(
						"You are a technical writer. Having the following:\n\n"
							.. "```\n{{selection}}\n```\n\n"
							.. "Please rewrite it with the following instruction: {{command}}",
						{
							has_prompt = true,
							target = gp.Target.rewrite,
							system_prompt = ai.system_prompts.casual_writer,
						}
					)
				end,
			},
		})
	end)
end

function M.setup()
	insertion_actions()
	selection_actions()
end

return M
