local constant = require("constant")
return {
	-- TODO update the config to use .vim folder when the setting bug is fixed. Currently it does not
	-- reflect the settings properly
	-- instructions_file = "./.vim/avante.md",
	provider = "claude-code",
	acp_providers = {
		["claude-code"] = {
			command = constant.NODEJS_PATH .. "/node",
			args = {
				constant.NODEJS_MODULES .. "/@zed-industries/claude-code-acp/dist/index.js",
			},
			env = {
				NODE_NO_WARNINGS = "1",
				ANTHROPIC_API_KEY = "", -- Ensure no accidental use of API key
			},
		},
	},
	selection = {
		enabled = false,
	},
	windows = {
		width = 50,
		input = {
			prefix = "▶ ",
		},
	},
	mappings = {
		submit = {
			normal = "<c-cr>",
			insert = "<c-cr>",
		},
		sidebar = {
			apply_all = "<c-cr>",
			apply_cursor = "<cr>",
			switch_windows = "<tab>",
			reverse_switch_windows = "<s-tab>",
			remove_file = "x",
			add_file = "a",
		},
	},
}
