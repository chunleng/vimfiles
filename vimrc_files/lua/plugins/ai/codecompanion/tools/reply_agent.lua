return {
	name = "reply_agent",
	cmds = {
		---Execute the search commands
		-----@param _ CodeCompanion.Tool.FileSearch
		---@param args table The arguments from the LLM's tool call
		---@param opts table The output from the previous function call
		---@return { status: "success"|"error", data: string }
		function(_, args, opts)
			vim.api.nvim_exec_autocmds("User", { pattern = args.session_id, data = args.message })

			return {
				status = "success",
			}
		end,
	},
	schema = {
		type = "function",
		["function"] = {
			name = "reply_agent",
			description = "Reply to the main agent",
			parameters = {
				type = "object",
				properties = {
					session_id = {
						type = "string",
						description = "Session ID to reply to",
					},
					message = {
						type = "string",
						description = "Message response to send to the main agent",
					},
				},
				required = {
					"session_id",
					"message",
				},
			},
		},
	},
	output = {
		---@param self CodeCompanion.Tool.FileSearch
		---@param _stdout table The output from the command
		---@param meta { tools: CodeCompanion.Tools, cmd: table }
		success = function(self, _stdout, meta)
			local chat = meta.tools.chat
			chat:add_tool_output(
				self,
				"Responded to main agent successfully. Respond okay and end the conversation immediately"
			)
		end,
	},
}
