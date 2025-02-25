local M = {}

function M.beforeSetup()
	-- global variables are not initialized properly in packer.config()
	-- and therefore we need to initialize them in packer.setup()
	vim.g.db_ui_use_nerd_fonts = 1
	vim.g.db_ui_show_database_icon = 1
end

function M.setup()
	local utils = require("common-utils")
	utils.keymap("n", "<c-s-s>", "<cmd>DBUIToggle<cr>")
	vim.g.db_ui_win_position = "right"
	vim.g.db_ui_table_helpers = {
		postgresql = {
			List = "SELECT * FROM {optional_schema}{table} ORDER BY 1 LIMIT 20",
			Columns = "SELECT\n  ordinal_position,\n  column_name,\n  udt_name,\n  is_nullable,\n  character_octet_length\n"
				.. "FROM information_schema.columns WHERE table_name='{table}' AND table_schema='{schema}' ORDER BY ordinal_position",
			Count = "SELECT COUNT(*) FROM {optional_schema}{table}",
		},
	}

	local theme = require("common-theme")
	theme.set_hl("NotificationError", {
		fg = theme.blender.error,
		bg = theme.blender.bg_lighter_1,
		blend = 10,
	})
	theme.set_hl("NotificationWarning", {
		fg = theme.blender.warn,
		bg = theme.blender.bg_lighter_1,
		blend = 10,
	})
	theme.set_hl("NotificationInfo", { fg = 15, bg = theme.blender.bg_lighter_1, blend = 10 })

	local group_name = "Dadbod"
	vim.api.nvim_create_augroup(group_name, { clear = true })
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "sql",
		callback = function()
			utils.buf_keymap(0, "n", "<c-cr>", "<cmd>w<cr>")
			utils.buf_keymap(0, "i", "<c-cr>", "<esc><cmd>w<cr>")
		end,
		group = group_name,
	})
end

return M
