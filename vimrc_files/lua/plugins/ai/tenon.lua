local utils = require("common-utils")

local function setup()
	local tenon = require("tenon")
	local tenon_constant = require("mod.global_constants").tenon

	local developer_base_agent = {
		model = tenon_constant.model_routing[tenon_constant.model_routing.alt_enabled].thinker,
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
			{ type = "system", name = "Read First Attitude", condition = "when making code changes" },
			{ type = "system", name = "YAGNI Attitude", condition = "when making code changes" },
			{ type = "system", name = "Code Comment Basics", condition = "when making code changes" },
			{ type = "system", name = "Testing Basics", condition = "when making test code changes" },
			{ type = "system", name = "Bug Isolation", condition = "when trying to understand cause of a bug" },
		},
	}
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
			assistant_developer = vim.tbl_deep_extend("keep", {
				workflows = {
					{ id = "implement_code_together", condition = "when user ask to collaborate or when coding" },
				},
			}, developer_base_agent),
			developer = vim.tbl_deep_extend("keep", {
				workflows = {
					{ id = "find_software_bug_root_cause" },
					{ id = "plan_refactoring" },
					{ id = "plan_software_change" },
					{ id = "implement_code" },
				},
			}, developer_base_agent),
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
					{ type = "system", name = "Read First Attitude", condition = "when editing prompt" },
					{
						type = "system",
						name = "No Perfect Solution Attitude",
						condition = "when giving feedback/reviewing",
					},
				},
				workflows = {
					{ id = "create_workflow" },
					{ id = "compact_text" },
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
					{ type = "system", name = "Read First Attitude", condition = "when reviewing code in the file" },
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
