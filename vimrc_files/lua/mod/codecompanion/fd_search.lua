local log = require("codecompanion.utils.log")

local fmt = string.format

---Search the current working directory for files matching the glob pattern.
---@param action { query: string, max_results: number }
---@return { status: "success"|"error", data: string }
local function search(action)
	local query = action.query
	if not query or query == "" then
		return {
			status = "error",
			data = "Query parameter is required and cannot be empty",
		}
	end

	local cwd = vim.fn.getcwd()

	local data = nil
	local data_err = nil
	local job_id = vim.fn.jobstart({ "fd", "--color=never", "--glob", "-p", cwd .. "/" .. query }, {
		stdout_buffered = true,
		stderr_buffered = true,
		on_stdout = function(_, d, _)
			table.remove(d) -- remove last line feed from output
			data = d
		end,
		on_stderr = function(_, d, _)
			table.remove(d) -- remove last line feed from output
			data_err = d
		end,
	})
	local res = vim.fn.jobwait({ job_id }, 5000)

	if res[1] == 0 then
		return {
			status = "success",
			data = data,
		}
	elseif res[1] == -1 then
		return {
			status = "error",
			data = { "execution timeout" },
		}
	else
		return {
			status = "error",
			data = data_err,
		}
	end
end

---@class CodeCompanion.Tool.FileSearch: CodeCompanion.Tools.Tool
return {
	name = "file_search",
	cmds = {
		---Execute the search commands
		-----@param _ CodeCompanion.Tool.FileSearch
		---@param args table The arguments from the LLM's tool call
		-----@param _? any The output from the previous function call
		---@return { status: "success"|"error", data: string }
		function(_, args, _)
			return search(args)
		end,
	},
	schema = {
		type = "function",
		["function"] = {
			name = "file_search",
			description = "Search for files in the workspace. This only returns the paths of matching files, less gitignored files. Use this tool when you know the filename pattern of the files you're searching for. Glob patterns match from the root of the workspace folder. Examples:\n- **/*.{js,ts} to match all js/ts files in the workspace.\n- src/** to match all files under the top-level src folder.\n- **/foo/**/*.js to match all js files under any foo folder in the workspace.",
			parameters = {
				type = "object",
				properties = {
					query = {
						type = "string",
						description = "Search for files with names or paths matching this glob pattern.",
					},
				},
				required = {
					"query",
				},
			},
		},
	},
	handlers = {
		---@param _ CodeCompanion.Tools The tool object
		---@return nil
		on_exit = function(_)
			log:trace("[File Search Tool] on_exit handler executed")
		end,
	},
	output = {
		---Returns the command that will be executed
		---@param self CodeCompanion.Tool.FileSearch
		---@param _ { tools: CodeCompanion.Tools }
		---@return string
		cmd_string = function(self, _)
			return self.args.query
		end,

		---The message which is shared with the user when asking for their approval
		---@param self CodeCompanion.Tools.Tool
		---@param _ CodeCompanion.Tools
		---@return nil|string
		prompt = function(self, _)
			return fmt("Search the cwd for `%s`?", self.args.query)
		end,

		---@param self CodeCompanion.Tool.FileSearch
		---@param tools CodeCompanion.Tools
		---@param _ table The command that was executed
		---@param stdout table The output from the command
		success = function(self, tools, _, stdout)
			local chat = tools.chat
			local query = self.args.query
			local data = stdout[1]

			local llm_output = "<fileSearchTool>%s</fileSearchTool>"
			local output = vim.iter(stdout):flatten():join("\n")

			if type(data) == "table" then
				-- Files were found - data is an array of file paths
				local files = #data
				local results_msg = fmt("Searched files for `%s`, %d results\n```\n%s\n```", query, files, output)
				chat:add_tool_output(self, fmt(llm_output, results_msg), results_msg)
			else
				-- No files found - data is a string message
				local no_results_msg = fmt("Searched files for `%s`, no results", query)
				chat:add_tool_output(self, fmt(llm_output, no_results_msg), no_results_msg)
			end
		end,

		---@param self CodeCompanion.Tool.FileSearch
		---@param tools CodeCompanion.Tools
		---@param _ table
		---@param stderr table The error output from the command
		error = function(self, tools, _, stderr)
			local chat = tools.chat
			local query = self.args.query
			local errors = vim.iter(stderr):flatten():join("\n")
			log:debug("[File Search Tool] Error output: %s", stderr)

			local error_output = fmt(
				[[Searched files for `%s`, error:

```txt
%s
```]],
				query,
				errors
			)
			chat:add_tool_output(self, error_output)
		end,
	},
}
