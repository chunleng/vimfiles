local function get_code_reviewer_agent()
	local tenon_constant = require("mod.global_constants").tenon
	return {
		model = tenon_constant.model_routing[tenon_constant.model_routing.alt_enabled].thinker,
		tool_names = {
			"list_files",
			"read_file",
			"search_text",
			"think",
		},
		directive = {
			{
				type = "text",
				value = 'Ensure code quality. focus: "Will unfamiliar reader understand in 6 months?". Technical tone. No hedging. Actionable feedback. No vague suggestions',
			},
			{
				type = "system",
				name = "No Perfect Solution Attitude",
				condition = "when giving feedback/reviewing",
			},
			{ type = "system", name = "Read First Attitude", condition = "when reviewing code in the file" },
			{ type = "system", name = "Code Review Process", condition = "when reviewing code" },
			{ type = "system", name = "AGENTS.md" },
		},
	}
end

return {
	get_code_reviewer_agent = get_code_reviewer_agent,
}
