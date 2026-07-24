local function get_technical_writer_agent()
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
			"move_path",
			"remove_path",
			"create_file",
			"edit_file",
		},
		directive = {
			{ type = "system", name = "Situation Sensitivity" },
			{ type = "system", name = "Read First Attitude", condition = "when editing documentation" },
		},
		workflows = { "create_pr_description", "edit_document" },
	}
end

return {
	get_technical_writer_agent = get_technical_writer_agent,
}
