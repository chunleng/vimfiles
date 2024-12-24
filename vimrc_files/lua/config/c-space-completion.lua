local M = {}

local utils = require("common-utils")
local ai = require("config.ai")
local gp = require("gp")
local neogen = require("neogen")
local prog_and_cfg_lang = vim.tbl_extend("keep", utils.programming_languages, utils.config_languages)

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
					ai.send(ai.agent.programmer_code, { range_type = ai.RangeType.ALL_BEFORE })
				end,
				ft = prog_and_cfg_lang,
			},
			{
				choice = "Casual Writer: Write Article",
				func = function()
					ai.send(ai.agent.casual_writer, { range_type = ai.RangeType.ALL_BEFORE })
				end,
				ft = utils.text_languages,
			},
			{
				choice = "Technical Writer: Write technical documents",
				func = function()
					ai.send(ai.agent.technical_writer, { range_type = ai.RangeType.ALL_BEFORE })
				end,
				ft = utils.text_languages,
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
					ai.send(ai.agent.programmer_code, { target = gp.Target.rewrite })
				end,
				ft = prog_and_cfg_lang,
			},
			{
				choice = "Programmer: Ask",
				func = function()
					ai.send(ai.agent.programmer_chat, { target = gp.Target.vnew("markdown") })
				end,
				ft = prog_and_cfg_lang,
			},
			{
				choice = "Programmer: Summarize Code",
				func = function()
					ai.send(ai.agent.programmer_chat, {
						template = "Please understand what the code is trying to do and respond with a summary the "
							.. "core logic in steps. Please remove unnecessary comments that are not useful for "
							.. "understanding the big picture of what the code is doing, e.g. import or printing",
						target = gp.Target.vnew("markdown"),
					})
				end,
				ft = prog_and_cfg_lang,
			},
			{
				choice = "Programmer: Code Review",
				func = function()
					ai.send(ai.agent.programmer_chat, {
						template = "Please analyze for code smells and suggest improvements that can make code "
							.. "easier to read.",
						target = gp.Target.vnew("markdown"),
					})
				end,
				ft = prog_and_cfg_lang,
			},
			{
				choice = "Programmer: Write Unit Test",
				func = function()
					ai.send(ai.agent.programmer_code, { template = "Please write unit test.", target = gp.Target.enew })
				end,
				ft = utils.programming_languages,
			},
			{
				choice = "Casual Writer: Refine Writing",
				func = function()
					ai.send(ai.agent.casual_writer, { target = gp.Target.rewrite })
				end,
				ft = utils.text_languages,
			},
			{
				choice = "Technical Writer: Refine Writing",
				func = function()
					ai.send(ai.agent.technical_writer, { target = gp.Target.rewrite })
				end,
				ft = utils.text_languages,
			},
		})
	end)
end

function M.setup()
	insertion_actions()
	selection_actions()
end

return M
