return {
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
			{ connector = "ollama_cloud", name = "kimi-k2.7-code" },
			{ connector = "ollama_cloud", name = "kimi-k2.6" },
			{ connector = "ollama_cloud", name = "gemma4:31b" },
			{ connector = "ollama_cloud", name = "minimax-m3" },
			{ connector = "ollama_cloud", name = "nemotron-3-ultra" },
			{ connector = "ollama_cloud", name = "nemotron-3-super" },
			{ connector = "ollama_cloud", name = "nemotron-3-nano:30b" },
			{ connector = "ollama_cloud", name = "deepseek-v4-pro" },
			{ connector = "ollama_cloud", name = "deepseek-v4-flash" },
			{ connector = "ollama_cloud", name = "qwen3.5" },
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
