local helpers = require("codecompanion.interactions.chat.tools.builtin.helpers")

---@class CodeCompanion.Tool.RunCommand: CodeCompanion.Tools.Tool
return {
	name = "run_command",
	system_prompt = [[<guidelines>
- Before using @{run_command}, always see if the same command can be performed using another tool, especially @{file_search} for listing file and @{read_file} for checking file content
- The cwd is resetted before running your command, so please refrain from performing unnecessary `cd`
</guidelines>]],
	cmds = {
		function(self, args, opts)
			local full_cmd = args.cmd .. " 2>&1"

			if args.filter_output then
				full_cmd = full_cmd .. " | grep " .. vim.fn.shellescape(args.filter_output)
			end
			if args.output_first_n_lines then
				full_cmd = full_cmd .. " | head -n " .. vim.fn.shellescape(args.output_first_n_lines)
			end
			if args.output_last_n_lines then
				full_cmd = full_cmd .. " | tail -n " .. vim.fn.shellescape(args.output_last_n_lines)
			end

			local data = {}
			vim.fn.jobstart({ "sh", "-c", full_cmd }, {
				on_stdout = function(_, d, _)
					table.insert(data, d)
				end,
				on_stderr = function(_, d, _)
					table.insert(data, d)
				end,
				on_exit = function()
					-- not using error code because it can pass if we use grep or head or tail, so it's not useful
					opts.output_cb({
						status = "success",
						data = data,
					})
				end,
			})
		end,
	},
	schema = {
		type = "function",
		["function"] = {
			name = "run_command",
			description = "Run command with basic output filtering operation",
			parameters = {
				type = "object",
				properties = {
					cmd = {
						type = "string",
						description = "The bash command to run, e.g. `make` or `git diff`",
					},
					filter_output = {
						type = "string",
						description = "Grep string to filter the output of the command. ",
					},
					output_first_n_lines = {
						type = "integer",
						description = "Only output the first n lines of the execution. Cannot be used together with output_last_n_lines",
					},
					output_last_n_lines = {
						type = "integer",
						description = "Only output the last n lines of the execution, Cannot be used together with output_first_n_lines",
					},
				},
				required = {
					"cmd",
				},
			},
		},
	},
	output = {
		---@param self CodeCompanion.Tools.Tool
		---@param _ { tools: CodeCompanion.Tools }
		---@return string
		cmd_string = function(self, _)
			return self.args.cmd
		end,

		---The message which is shared with the user when asking for their approval
		---@param self CodeCompanion.Tools.Tool
		---@param _ { tools: CodeCompanion.Tools }
		---@return nil|string
		prompt = function(self, _)
			return string.format("Run the command `%s`?", self.args.cmd)
		end,

		---Rejection message back to the LLM
		---@param self CodeCompanion.Tools.Tool
		---@param meta { tools: CodeCompanion.Tools, cmd: string, opts: table }
		---@return nil
		rejected = function(self, meta)
			local message = string.format(
				"The user rejected the execution of the `%s` tool. reason: %s",
				self.name,
				meta.opts.reason
			)
			meta = vim.tbl_extend("force", { message = message }, meta or {})
			helpers.rejected(self, meta)
		end,

		---@param self CodeCompanion.Tools.Tool
		---@param stdout table|nil The output from the tool
		---@param meta { tools: table, cmd: table }
		---@return nil
		success = function(self, stdout, meta)
			local chat = meta.tools.chat
			if stdout then
				local output = vim.iter(stdout[#stdout]):flatten():join("\n")
				local message = string.format(
					[[`%s`
````
%s
````]],
					self.args.cmd,
					output
				)
				return chat:add_tool_output(self, message)
			end
			return chat:add_tool_output(self, string.format("There was no output from the %s tool", self.name))
		end,
	},
}
