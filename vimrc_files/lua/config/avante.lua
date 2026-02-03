local M = {}

function M.get_avante_setup()
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
end

function M.setup()
	local utils = require("common-utils")
	local avante = require("avante")
	local avante_api = require("avante.api")

	-- Avante allows multiple call to setup, so by default we use the default call.
	-- This can be override if things needs to be changed on local level
	avante.setup(M.get_avante_setup())

	local group_name = "lAvante"
	vim.api.nvim_create_augroup(group_name, { clear = true })
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "Avante*",
		callback = function(opt)
			utils.buf_keymap(opt.buf, "n", "q", function()
				avante.toggle_sidebar()
			end)
			utils.buf_keymap(opt.buf, "n", "<c-s-h>", function()
				avante_api.select_history()
			end)
			utils.buf_keymap(opt.buf, "n", "<cr>", function()
				local sidebar = avante.get()
				sidebar.file_selector:show_selector_ui()
			end)
		end,
		group = group_name,
	})
	utils.keymap({ "n", "i" }, "<c-s-a>", "<cmd>AvanteChat<cr>")
end

return M
