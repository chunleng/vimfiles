return {
	name = "wait",
	cmds = {
		---Execute the search commands
		-----@param _ CodeCompanion.Tool.FileSearch
		---@param args table The arguments from the LLM's tool call
		---@param opts table The output from the previous function call
		---@return { status: "success"|"error", data: string }
		function(_, args, opts)
			vim.defer_fn(function()
				opts.output_cb({
					status = "success",
					data = string.format("Waited %d seconds", args.time_in_sec),
				})
			end, args.time_in_sec * 1000)
		end,
	},
	schema = {
		type = "function",
		["function"] = {
			name = "wait",
			description = "Wait for some time to pass. Please declare how long you are waiting before you call the tool",
			parameters = {
				type = "object",
				properties = {
					time_in_sec = {
						type = "integer",
						description = "The time in seconds to wait",
					},
				},
				required = {
					"time_in_sec",
				},
			},
		},
	},
	output = {
		---@param self CodeCompanion.Tool.FileSearch
		---@param stdout table The output from the command
		---@param meta { tools: CodeCompanion.Tools, cmd: table }
		success = function(self, stdout, meta)
			local chat = meta.tools.chat
			local data = stdout[1]

			chat:add_tool_output(self, "", data)
		end,
	},
}
