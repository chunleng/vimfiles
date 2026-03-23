return {
	name = "speak",
	cmds = {
		---Execute the search commands
		-----@param _ CodeCompanion.Tool.FileSearch
		---@param args table The arguments from the LLM's tool call
		---@param opts table The output from the previous function call
		---@return { status: "success"|"error", data: string }
		function(_, args, opts)
			vim.fn.jobstart({ "say", args.what_to_say }, {
				on_exit = function()
					-- not using error code because it can pass if we use grep or head or tail, so it's not useful
					opts.output_cb({
						status = "success",
						data = args.what_to_say,
					})
				end,
			})
		end,
	},
	schema = {
		type = "function",
		["function"] = {
			name = "speak",
			description = "Say something to the user using audio",
			parameters = {
				type = "object",
				properties = {
					what_to_say = {
						type = "string",
						description = "What to say to the user via the speaker",
					},
				},
				required = {
					"what_to_say",
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

			chat:add_tool_output(self, data, "Spoken to the user")
		end,
	},
}
