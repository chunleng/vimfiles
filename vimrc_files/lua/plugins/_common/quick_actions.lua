local utils = require("common-utils")

local M = {}

-- Quick action definitions
-- Each action has: name, description, condition (optional), callback
local actions = {
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

--- Show the quick actions using fzf-lua
function M.show()
	local fzf = require("fzf-lua")

	-- Filter actions by condition
	local available = {}
	for _, action in ipairs(actions) do
		if not action.condition or action.condition() then
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
							action.callback()
							break
						end
					end
				end
			end,
		},
	})
end

utils.keymap({ "n", "i" }, "<c-space>", M.show)

return {}
