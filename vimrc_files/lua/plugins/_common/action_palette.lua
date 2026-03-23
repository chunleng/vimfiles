local codecompanion_config = require("codecompanion.config")
local utils = require("common-utils")
local neogen = require("neogen")
local new_prompts = {
	{
		name = function()
			return "Docstring: function"
		end,
		interaction = "chat",
		description = "Add function docstring to current position using neogen",
		condition = function(context)
			if context.mode == "n" then
				return vim.tbl_contains(utils.programming_languages, context.filetype)
			else
				return false
			end
		end,
		opts = { stop_context_insertion = true },
		prompts = {
			n = function()
				neogen.generate({ type = "func" })
			end,
		},
	},
	{
		name = function()
			return "Docstring: class"
		end,
		interaction = "chat",
		description = "Add class docstring to current position using neogen",
		condition = function(context)
			if context.mode == "n" then
				return vim.tbl_contains(utils.programming_languages, context.filetype)
			else
				return false
			end
		end,
		opts = { stop_context_insertion = true },
		prompts = {
			n = function()
				return {}
			end,
		},
	},
	{
		name = function()
			return "Docstring: file"
		end,
		interaction = "chat",
		description = "Add file docstring to current position using neogen",
		condition = function(context)
			if context.mode == "n" then
				return vim.tbl_contains(utils.programming_languages, context.filetype)
			else
				return false
			end
		end,
		opts = { stop_context_insertion = true },
		prompts = {
			n = function()
				return {}
			end,
		},
	},
}

local result = {}
vim.list_extend(result, vim.list_slice(codecompanion_config.prompt_library, 1, 3))
vim.list_extend(result, new_prompts)
vim.list_extend(result, vim.list_slice(codecompanion_config.prompt_library, 4, #codecompanion_config.prompt_library))
codecompanion_config.prompt_library = result

return {}
