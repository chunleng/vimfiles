local utils = require("common-utils")

local M = {}

-- Quick action definitions
-- Each action has: name, description, condition (optional), callback
local actions = {
	{
		name = "Send selected text to chat",
		description = "Add the selected text to chat, with proper information about selection",
		condition = function(ctx)
			return ctx.mode == "v" or ctx.mode == "V" or ctx.mode == "\22"
		end,
		callback = function(ctx)
			local tenon = require("tenon")
			tenon.open()
			tenon.action.insert_selection(ctx.bufnr, ctx.start_line, ctx.start_col, ctx.end_line, ctx.end_col)
		end,
	},
	{
		name = "New chat",
		description = "Start a new tenon chat",
		callback = function()
			local tenon = require("tenon")
			tenon.open()
			vim.schedule(function()
				tenon.keymap.new_chat()
			end)
		end,
	},
	{
		name = "New chat with agent",
		description = "Start a new chat with specific agent",
		callback = function()
			local tenon = require("tenon")
			tenon.open()
			tenon.keymap.new_chat()
			tenon.keymap.select_agent()
		end,
	},
	{
		name = "Docstring: function",
		description = "Add function docstring using neogen",
		condition = function()
			return vim.tbl_contains(utils.programming_languages, vim.bo.filetype)
		end,
		callback = function()
			require("neogen").generate({ type = "func" })
		end,
	},
	{
		name = "Docstring: class",
		description = "Add class docstring using neogen",
		condition = function()
			return vim.tbl_contains(utils.programming_languages, vim.bo.filetype)
		end,
		callback = function()
			require("neogen").generate({ type = "class" })
		end,
	},
	{
		name = "Docstring: file",
		description = "Add file docstring using neogen",
		condition = function()
			return vim.tbl_contains(utils.programming_languages, vim.bo.filetype)
		end,
		callback = function()
			require("neogen").generate({ type = "file" })
		end,
	},
	{
		name = "Open history",
		description = "Load a chat from history",
		callback = function()
			require("tenon").keymap.select_history()
		end,
	},
}

--- Capture launch context (mode, buffer, selection bounds)
---@return table context {bufnr, mode, start_line, start_col, end_line, end_col}
local function capture_context()
	local mode = vim.fn.mode()
	local bufnr = vim.api.nvim_get_current_buf()
	local start_line, start_col, end_line, end_col

	if mode == "v" or mode == "\22" then
		-- Character-wise visual - get selection bounds
		local pos = vim.fn.getpos("v")
		start_line = pos[2]
		start_col = pos[3]
		local end_pos = vim.fn.getpos(".")
		end_line = end_pos[2]
		end_col = end_pos[3]

		-- Ensure start is before end
		if start_line > end_line or (start_line == end_line and start_col > end_col) then
			start_line, end_line = end_line, start_line
			start_col, end_col = end_col, start_col
		end
	elseif mode == "V" then
		-- Line-wise visual - columns are ignored
		local pos = vim.fn.getpos("v")
		start_line = pos[2]
		local end_pos = vim.fn.getpos(".")
		end_line = end_pos[2]

		-- Ensure start is before end
		if start_line > end_line then
			start_line, end_line = end_line, start_line
		end

		start_col = nil
		end_col = nil
	else
		-- Normal/insert mode - cursor position
		local pos = vim.api.nvim_win_get_cursor(0)
		start_line = pos[1]
		start_col = pos[2] + 1 -- nvim_win_get_cursor returns 0-based col
		end_line = start_line
		end_col = start_col
	end

	return {
		bufnr = bufnr,
		mode = mode,
		start_line = start_line,
		start_col = start_col,
		end_line = end_line,
		end_col = end_col,
	}
end

--- Show the quick actions using fzf-lua
function M.show()
	local fzf = require("fzf-lua")

	-- Capture launch context before fzf takes over
	local context = capture_context()

	-- Filter actions by condition
	local available = {}
	for _, action in ipairs(actions) do
		if not action.condition or action.condition(context) then
			table.insert(available, action)
		end
	end

	if #available == 0 then
		vim.notify("No actions available in current context", vim.log.levels.INFO)
		return
	end

	-- Find max name width for alignment
	local max_width = 0
	for _, action in ipairs(available) do
		max_width = math.max(max_width, #action.name)
	end

	local entries = {}
	for i, action in ipairs(available) do
		entries[i] = string.format("%-" .. max_width .. "s │ %s", action.name, action.description)
	end

	fzf.fzf_exec(entries, {
		prompt = "Select Action> ",
		fzf_opts = { ["--no-multi"] = true },
		actions = {
			["default"] = function(selected)
				if selected and #selected > 0 then
					-- Find the action by matching the selected entry
					local selected_text = selected[1]
					local selected_name = vim.trim(vim.split(selected_text, " │ ")[1])
					for _, action in ipairs(available) do
						if action.name == selected_name then
							action.callback(context)
							break
						end
					end
				end
			end,
		},
	})
end

utils.keymap({ "n", "i", "x" }, "<c-space>", M.show)

return {}
