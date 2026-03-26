---@class CodeCompanion.Tool.RunCommand: CodeCompanion.Tools.Tool
return {
	name = "git_diff",
	system_prompt = [[]],
	cmds = {
		function(_, args, opts)
			local data = {}

			vim.fn.jobstart({ "git", "diff", ("%s..%s"):format(args.from, args.to) }, {
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
			name = "git_diff",
			description = "Perform `git diff <from>..<to>` and returns the result",
			parameters = {
				type = "object",
				properties = {
					from = {
						type = "string",
						description = "The starting revision, or the version you are comparing from. This can be a branch, commit hash or revision references",
					},
					to = {
						type = "string",
						description = "The ending revision, or the version you are comparing to. This can be a branch, commit hash or revision references. Defaults to `HEAD`",
					},
				},
				required = {
					"from",
				},
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
				local diff_content = vim.iter(stdout[#stdout]):flatten():join("\n")
				return chat:add_tool_output(
					self,
					diff_content,
					("git diff %s..%s"):format(self.args.from, self.args.to)
				)
			end
		end,
	},
}
