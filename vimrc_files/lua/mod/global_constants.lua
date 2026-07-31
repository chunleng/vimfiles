return {
	tenon = {
		connectors = {
			ollama_cloud = {
				type = "ollama",
				base_url = "https://ollama.com",
				bearer = { env = "OLLAMA_API_KEY" },
			},
			zai = {
				type = "anthropic",
				base_url = "https://api.z.ai/api/anthropic",
				api_key = {
					env = "ZAI_API_KEY",
				},
			},
		},
		project_agents = vim.empty_dict(),
		model_type = {
			standard = "glm-5.2",
			thinker = "glm-5.2-zai",
			fast = "deepseek-v4-flash",
			vision = "qwen3.5",
		},
		models = {
			["glm-5.2"] = {
				connector = "ollama_cloud",
				name = "glm-5.2",
				default_parameters = { think = "medium", temperature = 0, top_p = 1 },
			},
			["glm-5.1"] = {
				connector = "ollama_cloud",
				name = "glm-5.1",
				default_parameters = { think = "medium", temperature = 0, top_p = 1 },
			},
			["kimi-k2.7-code"] = {
				connector = "ollama_cloud",
				name = "kimi-k2.7-code",
				default_parameters = { think = "high", temperature = 0, top_p = 1 },
			},
			["kimi-k2.6"] = {
				connector = "ollama_cloud",
				name = "kimi-k2.6",
				default_parameters = { think = "medium", temperature = 0, top_p = 1 },
			},
			["gemma4:31b"] = {
				connector = "ollama_cloud",
				name = "gemma4:31b",
				default_parameters = { think = "high", temperature = 0, top_p = 1 },
			},
			["minimax-m3"] = {
				connector = "ollama_cloud",
				name = "minimax-m3",
				default_parameters = { think = "high", temperature = 0, top_p = 1 },
			},
			["deepseek-v4-pro"] = {
				connector = "ollama_cloud",
				name = "deepseek-v4-pro",
				default_parameters = { think = "high", temperature = 0, top_p = 1 },
			},
			["deepseek-v4-flash"] = {
				connector = "ollama_cloud",
				name = "deepseek-v4-flash",
				default_parameters = { think = "medium", temperature = 0, top_p = 1 },
			},
			["qwen3.5"] = {
				connector = "ollama_cloud",
				name = "qwen3.5",
				default_parameters = { think = "max", temperature = 0, top_p = 1 },
			},
			["glm-5.2-zai"] = {
				connector = "zai",
				name = "glm-5.2",
				default_parameters = {
					thinking = { type = "enabled", budget_tokens = 10000 },
					max_tokens = 16000,
					temperature = 0,
				},
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
