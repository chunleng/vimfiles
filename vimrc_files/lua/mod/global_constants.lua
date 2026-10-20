return {
	git = {
		enable = true,
	},
	tenon = {
		connectors = {
			ollama_cloud = {
				type = "ollama",
				base_url = "https://ollama.com",
				bearer = { env = "OLLAMA_API_KEY" },
			},
		},
		project_agents = vim.empty_dict(),
		model_type = {
			standard = "glm-5.3-flash-high",
			thinker = "glm-5.3",
			fast = "glm-5.3-flash",
			vision = "glm-5.3-flash",
		},
		models = {
			["beam-1.0"] = {
				connector = "ollama_cloud",
				name = "beam",
				default_parameters = { think = "high", temperature = 0, top_p = 1 },
			},
			["glm-5.3-flash-high"] = {
				connector = "ollama_cloud",
				name = "glm-5.3-flash",
				vision = true,
				default_parameters = { think = "high", temperature = 0, top_p = 1 },
			},
			["glm-5.3-flash"] = {
				connector = "ollama_cloud",
				name = "glm-5.3-flash",
				vision = true,
				default_parameters = { think = "medium", temperature = 0, top_p = 1 },
			},
			["glm-5.3"] = {
				connector = "ollama_cloud",
				name = "glm-5.3",
				default_parameters = { think = "high", temperature = 0, top_p = 1 },
			},
			["glm-5.2"] = {
				connector = "ollama_cloud",
				name = "glm-5.2",
				default_parameters = { think = "high", temperature = 0, top_p = 1 },
			},
			["mistral-large-4"] = {
				connector = "ollama_cloud",
				name = "mistral-large-4",
				vision = true,
				default_parameters = { think = "high", temperature = 0, top_p = 1 },
			},
			["minimax-m3.1-flash"] = {
				connector = "ollama_cloud",
				name = "minimax-m3.1-flash",
				vision = true,
				default_parameters = { think = "high", temperature = 0, top_p = 1 },
			},
			["kimi-k3"] = {
				connector = "ollama_cloud",
				name = "kimi-k3",
				vision = true,
				default_parameters = { think = "high", temperature = 0, top_p = 1 },
			},
			["gemma4"] = {
				connector = "ollama_cloud",
				name = "gemma4",
				vision = true,
				default_parameters = { think = "high", temperature = 0, top_p = 1 },
			},
			["deepseek-v4-pro"] = {
				connector = "ollama_cloud",
				name = "deepseek-v4-pro:0813",
				default_parameters = { think = "high", temperature = 0, top_p = 1 },
			},
			["deepseek-v4.1-flash"] = {
				connector = "ollama_cloud",
				name = "deepseek-v4.1-flash:1017",
				vision = true,
				default_parameters = { think = "high", temperature = 0, top_p = 1 },
			},
			["nemotron-3-nano"] = {
				connector = "ollama_cloud",
				name = "nemotron-3-nano:30b",
				default_parameters = { think = "medium", temperature = 0, top_p = 1 },
			},
		},
		tools = {
			whitelist_commands = {},
			web_search_provider = {
				provider = "brave",
				api_key = { env = "BRAVE_API_KEY" },
				-- provider = "langsearch",
				-- api_key = { env = "LANGSEARCH_API_KEY" },
			},
		},
	},
	lualine = {
		-- additional_status will be added to lualine_x
		additional_status = function()
			return ""
		end,
	},
}
