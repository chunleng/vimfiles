local function setup_quick_replace()
	local utils = require("common-utils")

	-- Easy replace with selection
	utils.keymap("x", "<c-r>", function()
		local separator = ""
		local left_key = vim.api.nvim_replace_termcodes("<left>", true, false, true)
		-- TODO replace fzf-lua get_visual_selection function with
		-- https://github.com/neovim/neovim/issues/16843
		local feedkeys = (":%%s%s\\(%s\\)%s%sg%s%s"):format(
			separator,
			require("fzf-lua.utils").get_visual_selection(),
			separator,
			separator,
			left_key,
			left_key
		)
		vim.api.nvim_feedkeys(feedkeys, "n", false)
	end)
end

local function setup()
	local actions = require("fzf-lua.actions")
	local fzf = require("fzf-lua")
	fzf.setup({
		keymap = {
			builtin = {
				["<c-/>"] = "toggle-preview",
				["<s-down>"] = "preview-page-down",
				["<s-up>"] = "preview-page-up",
				["<tab>"] = "toggle+down",
				["<s-tab>"] = "toggle+up",
			},
			fzf = { ["enter"] = "select+accept" },
		},
		files = { git_icons = false, fd_opts = "--type f --type l --exclude .git --follow" },
		actions = { files = { ["default"] = actions.file_edit } },
		dap = {
			variables = {
				actions = {
					["default"] = function(selected)
						-- TODO Add to watch after the following issue is resolved
						-- https://github.com/rcarriga/nvim-dap-ui/issues/160
						-- local expr = string.match(selected[0], '%] (.*) = ')
						print(selected)
					end,
				},
			},
		},
		grep = { actions = { ["default"] = actions.file_edit_or_qf } },
		lsp = { actions = { ["default"] = actions.file_edit_or_qf } },
		diagnostics = { severity_limit = "INFO" },
		fzf_colors = {
			["fg"] = { "fg", "Normal" },
			["fg+"] = { "bg", "Normal" },
			["hl"] = { "fg", "FzfLuaFzfInfo" },
			["hl+"] = { "fg", "FzfLuaFzfInfo" },
			["bg"] = { "bg", "FzfLuaFloat" },
			["bg+"] = { "bg", "FzfLuaCursor" },
			["gutter"] = { "bg", "FzfLuaFloat" },
			["prompt"] = { "fg", "FzfLuaFzfPrompt" },
			["info"] = { "fg", "FzfLuaFzfInfo" },
			["marker"] = { "fg", "FzfLuaFzfMarker" },
		},
		fzf_args = "--select-1", -- auto-select when there is only one result
		file_icon_padding = " ",
	})
	local utils = require("common-utils")
	utils.keymap("n", "<enter>", ":FzfLua files<cr>")
	utils.keymap("n", "<c-s-b>", "<cmd>FzfLua buffers<cr>")
	utils.keymap("n", "<c-s-/>", ":FzfLua resume<cr>")
	utils.keymap("n", "g/", function()
		vim.ui.input({ prompt = "Search" }, function(response)
			if response == nil then
				return
			end
			require("fzf-lua.providers.grep").grep({ search = response })
		end)
	end)
	utils.keymap("x", "g/", ":<c-u>FzfLua grep_visual<cr>")
	utils.keymap("n", "<c-s-h>", function()
		vim.ui.select({ "help_tags", "man_pages" }, { prompt = "Help Menu" }, function(choice)
			vim.cmd("FzfLua " .. choice)
		end)
	end)

	local theme = require("common-theme")
	theme.set_hl("FzfLuaFloat", { link = "NormalFloat" })
	theme.set_hl("FzfLuaFloatBorder", { link = "FloatBorder" })
	theme.set_hl("FzfLuaCursor", { link = "PmenuSel" })
	theme.set_hl("FzfLuaPreviewBorder", { link = "FloatBorder" })
	theme.set_hl("FzfLuaPreviewNormal", { link = "NormalFloat" })
	theme.set_hl("FzfLuaPreviewTitle", { link = "NormalFloat" })
	theme.set_hl("FzfLuaFzfPrompt", { fg = 4 })
	theme.set_hl("FzfLuaFzfInfo", { fg = 4 })
	theme.set_hl("FzfLuaFzfMarker", { fg = 4 })

	theme.set_hl("FzfLuaNormal", { link = "NormalFloat" })
	theme.set_hl("FzfLuaTitle", { bold = true, bg = 236 })
	theme.set_hl("FzfLuaBorder", { link = "FloatBorder" })

	fzf.register_ui_select()

	setup_quick_replace()
end

return {
	{
		-- https://github.com/ibhagwan/fzf-lua
		-- https://github.com/nvim-tree/nvim-web-devicons
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = setup,
	},
}
