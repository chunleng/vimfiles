local function setup()
	local utils = require("common-utils")
	local avante = require("avante")
	local avante_api = require("avante.api")

	-- Avante allows multiple call to setup, so by default we use the default call.
	-- This can be override if things needs to be changed on local level
	avante.setup(require("mod.avante_config"))

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
return {
	{
		-- https://github.com/yetone/avante.nvim
		-- https://github.com/nvim-lua/plenary.nvim
		-- https://github.com/MunifTanjim/nui.nvim
		-- https://github.com/nvim-tree/nvim-web-devicons
		"yetone/avante.nvim",
		event = "VeryLazy",
		build = "make",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		config = setup,
	},
}
