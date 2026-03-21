--- This module only get initiated at project so that project can customize what commands are whitelisted
local M = {}

function M.with_whitelisted_commands(cmds)
	local run_project_command = vim.deepcopy(require("plugins.ai.codecompanion.tools.run_command"))
	run_project_command.name = "run_project_command"
	run_project_command.system_prompt = nil
	run_project_command.schema["function"].name = "run_project_command"

	run_project_command.schema["function"].parameters.properties.cmd = {
		type = "string",
		description = "The bash command",
		enum = cmds,
	}
	local original_cmd = vim.deepcopy(run_project_command.cmds[1])
	run_project_command.cmds[1] = function(self, args, opts)
		if vim.tbl_contains(cmds, args.cmd) then
			original_cmd(self, args, opts)
		else
			opts.output_cb({
				status = "error",
				data = "Command is not a whitelisted command",
			})
		end
	end

	return run_project_command
end

return M
-- vim: noet
