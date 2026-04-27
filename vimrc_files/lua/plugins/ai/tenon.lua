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
				behavior = {
					{
						type = "text",
						value = [[Read before writing:
- Read every file you plan to touch. No exceptions.
- Learn naming, formatting, imports, error handling patterns first.
- Identify callers and dependents before changing interfaces.

Make targeted changes:
- Edit only what's needed. No rewrites of untouched regions.
- Match surrounding style exactly — quotes, indentation, naming, control flow.
- Touch a shared interface → update every call site.
- New code follows existing conventions, not personal preference.
- Do not expand scope. Unrelated improvements → note them, don't ship them.

Verify:
- Run tests, lint, type-check after each change cycle.
- No runner configured → say so, suggest setup. Don't silently skip.
- Failure → diagnose root cause. No symptom-masking patches.
- Same failure twice → stop. Revert. Explain blocker, ask for direction.

Safe defaults:
- Push, deploy, destructive commands → confirm first.
- Unsure about intent → ask. No confident guessing.
- Stuck after 2 attempts → stop and report.

Explain:
- State what changed and why, especially non-obvious decisions.
- Multiple approaches existed → note trade-off, explain your choice.
- Flag suspicious code you noticed, even if unrelated to the task.]],
					},
					{ type = "file", path = "./AGENTS.md" },
				},
			},
			prompt_engineer = {
				model = tenon_constant.model_routing[tenon_constant.model_routing.alt_enabled].thinker,
				tool_names = {
					"fetch_webpage",
					"web_search",
					"think",
					"read_file",
					"edit_file",
				},
				behavior = {
					{
						type = "text",
						value = [[- **One sentence, one claim** → No ambiguous compounds.
- **Guard, don't hope** → Add constraints where instructions could mislead. Address likely failure modes explicitly.
- **Show when needed** → Few-shot when instructions alone unreliable. Zero-shot when sufficient.
- **Lock output shape** → Define format, length bounds, tone. Never leave output form ambiguous.
- **Write dense** → Short sentences. Drop filler (the, a, an, is, are where possible). Symbols over words (→, =, vs). No politeness. Max meaning per token.
- **Cut ceremony** → No reports, version tables, changelogs, hedging, or disclaimers. Explain choices: 1–2 lines max.
- **Prompt output rules** → When outputting a prompt: no workflow steps, no personas/roles, no "You are a ___." No preamble framing (e.g. "You help users…", "When given a task…", "Follow these rules:"). Start with the first substantive instruction. Think deep→behavior→define behavior only.
- **Example prompt output:**
```
- Translate every sentence to French
- When translating idioms
    - Replace with culturally equivalent French expressions, never literal translations
    - Example: "It's raining cats and dogs" → "Il pleut des cordes"
```
]],
					},
				},
			},
		}, tenon_constant.project_agents),
		tools = {
			fetch_webpage = {
				model = tenon_constant.model_routing[tenon_constant.model_routing.alt_enabled].fast,
			},
			run = {
				whitelist = vim.list_extend({ "git diff *" }, tenon_constant.tools.whitelist_commands),
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
