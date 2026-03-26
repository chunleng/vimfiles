---@class CodeCompanion.Tool.RunCommand: CodeCompanion.Tools.Tool
return {
	name = "git_current_branch",
	system_prompt = [[]],
	cmds = {
		function(self, args, opts)
			local data = {}

			vim.fn.jobstart({ "git", "branch", "--show-current" }, {
				on_stdout = function(_, d, _)
					table.insert(data, d)
				end,
				on_stderr = function(_, d, _)
					table.insert(data, d)
				end,
				on_exit = function(_, exit_code, _)
					if exit_code == 0 then
						opts.output_cb({
							status = "success",
							data = data,
						})
					else
						opts.output_cb({
							status = "error",
							data = data,
						})
					end
				end,
			})
		end,
	},
	schema = {
		type = "function",
		["function"] = {
			name = "git_current_branch",
			description = "Get the current working branch of git",
			parameters = {
				type = "object",
				properties = vim.empty_dict(),
				required = {},
			},
		},
	},
	output = {

		---@param self CodeCompanion.Tools.Tool
		---@param stderr table The error output from the command
		---@param meta { tools: CodeCompanion.Tools, cmd: table }
		error = function(self, stderr, meta)
			local chat = meta.tools.chat
			local errors = vim.iter(stderr):flatten():join("\n")
			chat:add_tool_output(self, errors)
		end,

		---@param self CodeCompanion.Tools.Tool
		---@param stdout table|nil The output from the tool
		---@param meta { tools: table, cmd: table }
		---@return nil
		success = function(self, stdout, meta)
			local chat = meta.tools.chat
			if stdout and #stdout > 0 then
				local branch = vim.iter(stdout[#stdout]):flatten():next()
				return chat:add_tool_output(self, "Current branch: " .. branch)
			end
		end,
	},
}
