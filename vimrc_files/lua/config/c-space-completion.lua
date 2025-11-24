local M = {}

local utils = require("common-utils")
local avante = require("avante.api")
local neogen = require("neogen")

local function avante_edit(request)
	request = request or ""
	local start_line, end_line
	local mode = vim.fn.mode()

	if mode == "v" or mode == "V" or mode == "\22" then
		-- Visual mode: get visual selection range
		start_line = vim.fn.line("'<")
		end_line = vim.fn.line("'>")
	else
		-- Fallback for other modes
		start_line = vim.fn.line(".")
		end_line = vim.fn.line(".")
	end

	avante.edit(request, start_line, end_line)
end

local function avante_ask_about_selection(question)
	local start_line = vim.fn.line("'<")
	local end_line = vim.fn.line("'>")
	avante.ask({
		question = string.format("Using only line %d to %d of the selected file. %s", start_line, end_line, question),
		new_chat = true,
	})
end

local function insertion_actions()
	utils.keymap({ "n", "i" }, "<c-space>", function()
		utils.action_menu({
			{
				choice = "AI: Complete code",
				func = function()
					avante_edit(
						"Complete code, replacing only the current line with valid code. "
							.. "Please do not attempt to correct code on other lines"
					)
				end,
				ft = utils.prog_and_cfg_lang,
			},
			{
				choice = "AI: Edit line",
				func = function()
					avante_edit()
				end,
			},
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
		})
	end, { silent = false })
end

local function selection_actions()
	utils.keymap("v", "<c-space>", function()
		utils.action_menu({
			{
				choice = "AI: Edit selected line(s)",
				func = function()
					avante_edit()
				end,
			},
			{
				choice = "ZK: Add ZK link at selection",
				func = function()
					vim.cmd("'<,'>ZkInsertLinkAtSelection")
				end,
				ft = { "markdown" },
			},
			{
				choice = "AI: Summarize Code",
				func = function()
					avante_ask_about_selection(
						"Please try and understand what the code is trying to do and respond with the core logic in steps. "
							.. "Please do not include code or comments that are not useful for the understanding, such as import or printing"
					)
				end,
				ft = utils.programming_languages,
			},
			{
				choice = "AI: Write Unit Test",
				func = function()
					avante_ask_about_selection("Please implement the unit test for the selected code")
				end,
				ft = utils.programming_languages,
			},
			{
				choice = "AI: Review Code",
				func = function()
					avante_ask_about_selection(
						"Please analyze for code smells and suggest improvements that can make code easier to read"
					)
				end,
				ft = utils.programming_languages,
			},
		})
	end)
end

function M.setup()
	insertion_actions()
	selection_actions()
end

return M
