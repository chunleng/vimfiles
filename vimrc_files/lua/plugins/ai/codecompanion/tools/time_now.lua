return {
	name = "time_now",
	cmds = {
		---Execute the search commands
		-----@param _ CodeCompanion.Tool.FileSearch
		---@param args table The arguments from the LLM's tool call
		---@param opts table The output from the previous function call
		---@return { status: "success"|"error", data: string }
		function(_, args, opts)
			local format_string = "%a, %d %b %Y %H:%M:%S"
			if args.format == "unix_timestamp" then
				format_string = "!%s"
			end
			return {
				status = "success",
				data = os.date(format_string, os.time()),
			}
		end,
	},
	schema = {
		type = "function",
		["function"] = {
			name = "time_now",
			description = "Get the current time in the user's timezone",
			parameters = {
				type = "object",
				properties = {
					format = {
						type = "string",
						enum = { "human_readable", "unix_timestamp" },
						description = "The time in seconds to wait",
					},
				},
				required = {},
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

			local results_msg = string.format("Time now is %s", data)
			chat:add_tool_output(self, data, results_msg)
		end,
	},
}
