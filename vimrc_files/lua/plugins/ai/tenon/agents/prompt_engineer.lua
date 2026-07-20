local function get_prompt_engineer_agent()
	local tenon_constant = require("mod.global_constants").tenon
	return {
		model = tenon_constant.model_routing[tenon_constant.model_routing.alt_enabled].thinker,
		tool_names = {
			"list_files",
			"read_file",
			"search_text",
			"web_search",
			"fetch_webpage",
			"move_path",
			"remove_path",
			"create_file",
			"edit_file",
		},
		directive = {
			{ type = "system", name = "Prompting Basics" },
			{ type = "system", name = "Prompt Editing Basics", condition = "when editing prompt" },
			{ type = "system", name = "Read First Attitude", condition = "when editing prompt" },
			{
				type = "system",
				name = "No Perfect Solution Attitude",
				condition = "when giving feedback/reviewing",
			},
		},
		workflows = { "create_workflow", "create_directive", "compact_prompt" },
	}
end

return {
	get_prompt_engineer_agent = get_prompt_engineer_agent,
}
