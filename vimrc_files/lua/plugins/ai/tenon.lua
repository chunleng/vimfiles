local utils = require("common-utils")

local function setup()
	local tenon = require("tenon")
	local tenon_constant = require("mod.global_constants").tenon
	local developer = require("plugins.ai.tenon.agents.developer")
	local prompt_engineer = require("plugins.ai.tenon.agents.prompt_engineer")
	local code_reviewer = require("plugins.ai.tenon.agents.code_reviewer")

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
				},
				default = true,
			},
			assistant_developer = developer.get_assistant_developer_agent(),
			developer = developer.get_developer_agent(),
			prompt_engineer = prompt_engineer.get_prompt_engineer_agent(),
			code_reviewer = code_reviewer.get_code_reviewer_agent(),
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
