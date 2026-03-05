local tool_execution_precheck = require("plugins.ai.codecompanion.tools.tool_execution_precheck")
return tool_execution_precheck.wrap(
	require("codecompanion.interactions.chat.tools.builtin.read_file"),
	function(_, args, _)
		return tool_execution_precheck.validate_safe_filepath(args.filepath)
	end
)
