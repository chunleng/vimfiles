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
			"edit_file",
		},
		directive = {
			{ type = "system", name = "AGENTS.md" },
			{ type = "system", name = "Read First Attitude", condition = "when editing documentation" },
		},
		choreos = {
			"create_pr_description",
			"create_software_specification",
			"assess_project_doc_needs",
			"edit_howto_document",
			"edit_reference_document",
			"edit_explanation_document",
			"edit_tutorial_document",
		},
	}
end

return {
	get_technical_writer_agent = get_technical_writer_agent,
}
