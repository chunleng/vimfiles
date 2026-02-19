local chat_helpers = require("codecompanion.interactions.chat.helpers")
local ui_utils = require("codecompanion.utils.ui")

local SlashCommand = {}

---@param args CodeCompanion.SlashCommandArgs
function SlashCommand.new(args)
	local self = setmetatable({
		Chat = args.Chat,
		config = args.config,
		context = args.context,
		opts = args.opts,
	}, { __index = SlashCommand })

	return self
end

---Execute the slash command
---@param self CodeCompanion.SlashCommands
---@return nil
function SlashCommand:execute()
	ui_utils.input({ prompt = "File path" }, function(filepath)
		self:output(filepath)
	end)
end
---
---@param filepath string
---@return nil
function SlashCommand:output(filepath)
	if vim.fn.filereadable(filepath) == 0 then
		vim.api.nvim_echo({ { "Error: Filepath " .. filepath .. " does not exist", "ErrorMsg" } }, true, {})
		return
	end

	local file = require("codecompanion.interactions.chat.slash_commands.builtin.file").new({
		Chat = self.Chat,
		config = {},
		context = {},
		opts = {},
	})
	file:output({ path = filepath }, { silent = true })
end

return SlashCommand
