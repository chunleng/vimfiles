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
		connectors = nil, -- Use default
		project_agents = vim.empty_dict(),
		model_routing = {
			alt_enabled = vim.env.TENON_MODEL_ALT or "alt_1",
			alt_1 = {
				standard = { connector = "ollama_cloud", name = "glm-5" },
				thinker = { connector = "ollama_cloud", name = "glm-5" },
				fast = { connector = "ollama_cloud", name = "deepseek-v4-flash" },
			},
			alt_2 = {
				standard = { connector = "zai", name = "glm-5-turbo" },
				thinker = { connector = "zai", name = "glm-5" },
				fast = { connector = "zai", name = "glm-4.5-air" },
			},
		},
		models = {
			{ connector = "ollama_cloud", name = "glm-5.1" },
			{ connector = "ollama_cloud", name = "glm-5" },
			{ connector = "ollama_cloud", name = "kimi-k2.6" },
			{ connector = "ollama_cloud", name = "gemma4:31b" },
			{ connector = "ollama_cloud", name = "nemotron-3-super" },
			{ connector = "ollama_cloud", name = "deepseek-v4-flash" },
			{ connector = "zai", name = "glm-5.1" },
			{ connector = "zai", name = "glm-5-turbo" },
			{ connector = "zai", name = "glm-5" },
			{ connector = "zai", name = "glm-4.7" },
			{ connector = "zai", name = "glm-4.5-air" },
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
