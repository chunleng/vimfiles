local function get_researcher_agent()
	local tenon_constant = require("mod.global_constants").tenon
	return {
		model = tenon_constant.model_type.standard,
		tool_names = {
			"list_files",
			"read_file",
			"analyze_image",
			"search_text",
			"web_search",
			"fetch_webpage",
		},
		directive = {
			{ type = "system", name = "Speak With Facts" },
		},
	}
end

return {
	get_researcher_agent = get_researcher_agent,
}
