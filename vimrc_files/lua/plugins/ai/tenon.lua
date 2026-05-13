local utils = require("common-utils")

local function setup()
	local tenon = require("tenon")
	local tenon_constant = require("mod.global_constants").tenon
	tenon.setup({
		connectors = tenon_constant.connectors,
		-- Z.ai models
		-- * glm-5.1
		-- * glm-5-turbo
		-- * glm-5
		-- * glm-4.7
		-- * glm-4.5-air
		agents = vim.tbl_extend("force", {
			generic = {
				model = tenon_constant.model_routing[tenon_constant.model_routing.alt_enabled].standard,
				tool_names = {
					"fetch_webpage",
					"list_files",
					"read_file",
					"search_text",
					"web_search",
					"think",
					"calculator",
				},
				default = true,
			},
			developer = {
				model = tenon_constant.model_routing[tenon_constant.model_routing.alt_enabled].thinker,
				tool_names = {
					"create_file",
					"edit_file",
					"fetch_webpage",
					"list_files",
					"read_file",
					"remove_path",
					"move_path",
					"search_text",
					"web_search",
					"run",
					"think",
				},
				directive = {
					{
						type = "text",
						value = [[Make targeted changes:
- Match surrounding style exactly — quotes, indentation, naming, control flow.
- Touch a shared interface → update every call site.
- New code follows existing conventions, not personal preference.

Verify:
- Run tests, lint, type-check after each change cycle.
- No runner configured → say so, suggest setup. Don't silently skip.

Safe defaults:
- Push, deploy, destructive commands → confirm first.
- Unsure about intent → ask. No confident guessing.
- Stuck after 2 attempts → stop and report.

Explain:
- State what changed and why, especially non-obvious decisions.
- Multiple approaches existed → note trade-off, explain your choice.
- Comment only non-obvious code. Explain why, not what.
- Flag suspicious code you noticed, even if unrelated to the task.]],
					},
					{ type = "system", name = "Read First Attitude", condition = "when editing code" },
					{ type = "system", name = "YAGNI Attitude", condition = "when editing code" },
					{ type = "system", name = "Bug Isolation" },
					{ type = "system", name = "AGENTS.md" },
				},
				workflows = {
					{ id = "find_software_bug_root_cause" },
					{ id = "implement_software" },
				},
			},
			prompt_engineer = {
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
					{
						type = "system",
						name = "Prompt Editing Basics",
						condition = "when dealing with prompt/text-to-LLM related operations",
					},
					{ type = "system", name = "Read First Attitude", condition = "when editing prompt" },
					{
						type = "system",
						name = "No Perfect Solution Attitude",
						condition = "when giving feedback/reviewing",
					},
					{
						type = "system",
						name = "Caveman Mode",
						condition = "when compacting or asked to. never apply to chat",
					},
				},
				workflows = {
					{ id = "create_workflow" },
				},
			},
			code_reviewer = {
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
					{ type = "system", name = "Code Review Process", condition = "when reviewing code" },
					{ type = "system", name = "AGENTS.md" },
				},
			},
		}, tenon_constant.project_agents),
		tools = {
			fetch_webpage = {
				model = tenon_constant.model_routing[tenon_constant.model_routing.alt_enabled].fast,
			},
			run = {
				whitelist = vim.list_extend(
					{ "git diff *", "git show *", "git status *" },
					tenon_constant.tools.whitelist_commands
				),
				check_models = {
					tenon_constant.model_routing[tenon_constant.model_routing.alt_enabled].fast,
					tenon_constant.model_routing[tenon_constant.model_routing.alt_enabled].standard,
				},
			},
		},
		history = {
			directory = vim.fn.getcwd() .. "/.vim/history",
		},
		models = tenon_constant.models,
		title = {
			model = tenon_constant.model_routing[tenon_constant.model_routing.alt_enabled].fast,
		},
	})
	utils.keymap({ "n", "i" }, "<c-s-a>", function()
		tenon.toggle()
	end)
end

return {
	{
		dir = "~/workspace-bootstrap/git/chunleng/tenon.nvim/",
		config = setup,
	},
}
