return {
	codecompanion = {
		models = {
			general = {
				name = "ollama_online",
				adapter = "ollama_online",
				model = "glm-5",
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
		},
	},
	lualine = {
		-- additional_status will be added to lualine_x
		additional_status = function()
			return ""
		end,
	},
}
