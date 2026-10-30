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
				parameters = {
					think = { default_value = "medium" },
					-- Recommended default for temperature/top_p is 1.0/0.95 for modern models, it's usually what is
					-- used for benchmark evals
					temperature = { default_value = 1.0 },
					top_p = { default_value = 0.95 },
				},
			},
		},
		project_agents = vim.empty_dict(),
		model_type = {
			standard = { id = "glm-5.3-flash" },
			thinker = { id = "glm-5.3", parameter_overrides = { think = "high" } },
			fast = { id = "glm-5.3-flash" },
			vision = { id = "glm-5.3-flash" },
		},
		models = {
			["beam-1.0"] = { connector = "ollama_cloud", name = "beam" },
			-- https://docs.z.ai/guides/vlm/glm-5.3-flash recommends temperature=1.0 and top_p=0.95 for glm-5.3-flash
			["glm-5.3-flash"] = { connector = "ollama_cloud", name = "glm-5.3-flash", vision = true },
			["glm-5.3"] = { connector = "ollama_cloud", name = "glm-5.3" },
			["mistral-large-4"] = { connector = "ollama_cloud", name = "mistral-large-4", vision = true },
			["minimax-m3.1-flash"] = { connector = "ollama_cloud", name = "minimax-m3.1-flash", vision = true },
			-- https://huggingface.co/moonshotai/Kimi-K3 recommends temperature=1.0 and top_p=0.95 for kimi-k3
			["kimi-k3"] = { connector = "ollama_cloud", name = "kimi-k3", vision = true },
			["gemma4"] = { connector = "ollama_cloud", name = "gemma4", vision = true },
			["deepseek-v4-pro"] = { connector = "ollama_cloud", name = "deepseek-v4-pro:0813" },
			["deepseek-v4.1-flash"] = { connector = "ollama_cloud", name = "deepseek-v4.1-flash:1017", vision = true },
			["nemotron-3-nano"] = { connector = "ollama_cloud", name = "nemotron-3-nano:30b" },
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
