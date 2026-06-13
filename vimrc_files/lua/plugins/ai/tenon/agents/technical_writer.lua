local function get_technical_writer_agent()
	local tenon_constant = require("mod.global_constants").tenon
	return {
		model = tenon_constant.model_routing[tenon_constant.model_routing.alt_enabled].standard,
		tool_names = {
			"think",
			"list_files",
			"read_file",
			"web_search",
			"fetch_webpage",
			"search_text",
			"create_file",
			"edit_file",
		},
		directive = {
			{ type = "system", name = "Read First Attitude", condition = "when editing documentation" },
		},
		workflows = {
			{ id = "edit_document" },
		},
	}
end

return {
	get_technical_writer_agent = get_technical_writer_agent,
}
