return {
	git = {
		enable = true,
	},
	tenon = {
		connectors = {
			ollama_cloud = {
				type = "ollama",
				base_url = "https://ollama.com",
				api_key = { env = "OLLAMA_API_KEY" },
				parameters = {
					think = { default_value = "medium", options = { false, "low", "medium", "high", "max" } },
					-- Recommended default for temperature/top_p is 1.0/0.95 for modern models, it's usually what is
					-- used for benchmark evals
					temperature = { default_value = 1.0 },
					top_p = { default_value = 0.95 },
				},
			},
			openrouter_openai = {
				type = "openai_response",
				base_url = "https://openrouter.ai/api/v1",
				api_key = { env = "OPENROUTER_API_KEY" },
				parameters = {
					reasoning = {
						default_value = { effort = "medium", summary = "auto" },
						options = {
							{ effort = "none" },
							{ effort = "low", summary = "auto" },
							{ effort = "medium", summary = "auto" },
							{ effort = "high", summary = "auto" },
							{ effort = "xhigh", summary = "auto" },
							{ effort = "max", summary = "auto" },
						},
					},
					provider = {
						default_value = { zdr = true },
					},
				},
			},
			subq = {
				type = "openai_completion",
				base_url = "https://api.subq.ai/v1",
				api_key = { env = "SUBQ_API_KEY" },
				parameters = {
					reasoning_effort = {
						default_value = "high",
						options = {
							"low",
							"high",
							"max",
						},
					},
					store = {
						default_value = "false",
					},
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
			-- TODO disable 6.2 for now because of bug in caching
			-- https://community.openai.com/t/gpt-6-2-sol-text-in-instructions-is-never-prompt-cached-cached-tokens-and-cache-write-tokens-stay-0-while-the-same-text-as-a-developer-message-caches-fine/1417570/4
			-- ["gpt-6.2-astra"] = { connector = "openrouter_openai", name = "openai/gpt-6.2-astra" },
			-- ["gpt-6.2-sol"] = { connector = "openrouter_openai", name = "openai/gpt-6.2-sol" },
			["gpt-6.1-sol"] = { connector = "openrouter_openai", name = "openai/gpt-6.1-sol" },
			["subq-savant-1.4"] = { connector = "subq", name = "subq-savant-1.4" },
			["beam-1.0"] = { connector = "ollama_cloud", name = "beam" },
			["inkling-2-small"] = { connector = "ollama_cloud", name = "inkling-2-small", vision = true },
			-- https://docs.z.ai/guides/vlm/glm-5.3-flash recommends temperature=1.0 and top_p=0.95 for glm-5.3-flash
			["glm-5.3-flash"] = { connector = "ollama_cloud", name = "glm-5.3-flash", vision = true },
			["glm-5.3"] = { connector = "ollama_cloud", name = "glm-5.3" },
			["mistral-large-4"] = { connector = "ollama_cloud", name = "mistral-large-4", vision = true },
			["minimax-m3.1-flash"] = { connector = "ollama_cloud", name = "minimax-m3.1-flash", vision = true },
			["hy4"] = { connector = "ollama_cloud", name = "hy4", vision = true },
			-- https://huggingface.co/moonshotai/Kimi-K3 recommends temperature=1.0 and top_p=0.95 for kimi-k3
			["kimi-k3.1"] = { connector = "ollama_cloud", name = "kimi-k3.1-pro", vision = true },
			["gemma4"] = { connector = "ollama_cloud", name = "gemma4", vision = true },
			["deepseek-v4-pro"] = { connector = "ollama_cloud", name = "deepseek-v4-pro:0813" },
			["deepseek-v4.1-flash"] = { connector = "ollama_cloud", name = "deepseek-v4.1-flash:1017", vision = true },
			["mimo-v2.6-flash"] = { connector = "ollama_cloud", name = "mimo-v2.6-flash", vision = true },
			["mimo-v2.6-pro"] = { connector = "ollama_cloud", name = "mimo-v2.6-pro", vision = true },
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
