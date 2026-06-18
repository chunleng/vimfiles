local function get_prompt_engineer_agent()
	local tenon_constant = require("mod.global_constants").tenon
	return {
		model = tenon_constant.model_routing[tenon_constant.model_routing.alt_enabled].thinker,
		tool_names = {
			"fetch_webpage",
			"web_search",
			"think",
			"create_file",
			"read_file",
			"edit_file",
			"search_text",
			"list_files",
		},
		directive = {
			{ type = "system", name = "Prompting Basics" },
			{ type = "system", name = "Read First Attitude", condition = "when editing prompt" },
			{
				type = "system",
				name = "No Perfect Solution Attitude",
				condition = "when giving feedback/reviewing",
			},
		},
		workflows = {
			{ id = "create_workflow" },
			{ id = "compact_prompt" },
		},
	}
end

return {
	get_prompt_engineer_agent = get_prompt_engineer_agent,
}
