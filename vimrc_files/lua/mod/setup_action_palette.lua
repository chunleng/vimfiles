local codecompanion_config = require("codecompanion.config")
local utils = require("common-utils")
local neogen = require("neogen")
local prepend_prompts = {
	{
		name = function()
			return "Docstring: function"
		end,
		interaction = "chat",
		description = "Add function docstring to current position using neogen",
		condition = function(context)
			return vim.tbl_contains(utils.programming_languages, context.filetype)
		end,
		opts = { stop_context_insertion = true, modes = { "n" } },
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
			return vim.tbl_contains(utils.programming_languages, context.filetype)
		end,
		opts = { stop_context_insertion = true, modes = { "n" } },
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
			return vim.tbl_contains(utils.programming_languages, context.filetype)
		end,
		opts = { stop_context_insertion = true, modes = { "n" } },
		prompts = {
			n = function()
				return {}
			end,
		},
	},
}

vim.list_extend(prepend_prompts, codecompanion_config.prompt_library)
codecompanion_config.prompt_library = prepend_prompts

return {}
