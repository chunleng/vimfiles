return {
	codecompanion = {
		models = {
			general = {
				name = "ollama_online",
				adapter = "ollama_online",
				model = "glm-5.1",
			},
			coding = {
				name = "copilot",
				adapter = "copilot",
				model = "claude-sonnet-4.5",
			},
			coding_secondary = {
				name = "copilot",
				adapter = "copilot",
				model = "gpt-5.3-codex",
			},
			agentic = {
				name = "copilot",
				adapter = "copilot",
				model = "claude-opus-4.5",
			},
			cheap = {
				name = "copilot",
				adapter = "copilot",
				model = "gpt-4.1",
			},
			fast = {
				name = "ollama_online",
				adapter = "ollama_online",
				model = "gemini-3-flash-preview",
			},
		},
		git = {
			tools = {},
			groups = {},
			meta = nil,
		},
		issue = {
			tools = {},
			groups = {},
			meta = nil,
		},
		whitelist = {
			additional_readable_directory = {},
			allowed_commands = nil,
		},
	},
	tenon = {
		project_agents = vim.empty_dict(),
		models = {
			alt_enabled = vim.env.TENON_MODEL_ALT or "alt_1",
			alt_1 = {
				standard = { connector = "ollama_cloud", name = "glm-5.1" },
				cheap = { connector = "ollama_cloud", name = "nemotron-3-super" },
				thinker = { connector = "ollama_cloud", name = "glm-5.1" },
			},
			alt_2 = {
				standard = { connector = "zai", name = "glm-5-turbo" },
				cheap = { connector = "zai", name = "glm-4.5-air" },
				thinker = { connector = "zai", name = "glm-5.1" },
			},
		},
		tools = {
			whitelist_commands = {},
		},
	},
	lualine = {
		-- additional_status will be added to lualine_x
		additional_status = function()
			return ""
		end,
	},
}
