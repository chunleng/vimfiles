local function get_developer_base_agent()
	return {
		tool_names = {
			"think",
			"list_files",
			"read_file",
			"search_text",
			"web_search",
			"fetch_webpage",
			"move_path",
			"remove_path",
			"create_file",
			"edit_file",
			"run",
		},
		directive = {
			{ type = "system", name = "AGENTS.md" },
			{ type = "system", name = "Reduce Commentary" },
			{ type = "system", name = "Read First Attitude", condition = "when making code changes" },
			{ type = "system", name = "YAGNI Attitude", condition = "when making code changes" },
			{ type = "system", name = "Code Comment Basics", condition = "when making code changes" },
			{ type = "system", name = "Testing Basics", condition = "when making test code changes" },
			{ type = "system", name = "Bug Isolation", condition = "when trying to understand cause of a bug" },
		},
	}
end

local function get_developer_agent()
	local base = get_developer_base_agent()
	local tenon_constant = require("mod.global_constants").tenon
	return vim.tbl_deep_extend("keep", {
		model = tenon_constant.model_routing[tenon_constant.model_routing.alt_enabled].thinker,
		workflows = {
			{ id = "find_software_bug_root_cause" },
			{ id = "plan_refactoring" },
			{ id = "plan_software_change" },
			{ id = "implement_code" },
		},
	}, base)
end

local function get_assistant_developer_agent()
	local base = get_developer_base_agent()
	local tenon_constant = require("mod.global_constants").tenon
	return vim.tbl_deep_extend("keep", {
		model = tenon_constant.model_routing[tenon_constant.model_routing.alt_enabled].standard,
		workflows = {
			{
				id = "implement_code_together",
				condition = "any request that has shows intention of code change",
			},
		},
	}, base)
end

return {
	get_developer_agent = get_developer_agent,
	get_assistant_developer_agent = get_assistant_developer_agent,
}
