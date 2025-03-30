local M = {}

function M.setup()
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
		hls = { normal = "FzfLuaFloat", border = "FzfLuaFloatBorder" },
		fzf_colors = {
			["bg"] = { "bg", "FzfLuaFloat" },
			["bg+"] = { "bg", "FzfLuaCursor" },
			["gutter"] = { "bg", "FzfLuaFloat" },
		},
		fzf_args = "--select-1", -- auto-select when there is only one result
		file_icon_padding = " ",
	})
	function _G.fzf_lua_search()
		vim.ui.input({ prompt = "Search" }, function(response)
			if response == nil then
				return
			end
			require("fzf-lua.providers.grep").grep({ search = response })
		end)
	end
	vim.cmd([[command! FzfLuaSearch call v:lua.fzf_lua_search()]])
	local utils = require("common-utils")
	utils.keymap("n", "<enter>", ":FzfLua files<cr>")
	utils.keymap("n", "<c-s-b>", "<cmd>FzfLua buffers<cr>")
	utils.keymap("n", "<c-s-d>", function()
		utils.action_menu({
			{
				choice = "Breakpoints",
				func = function()
					vim.cmd("FzfLua dap_breakpoints")
				end,
			},
			{
				choice = "Variables",
				func = function()
					vim.cmd("FzfLua dap_variables")
				end,
			},
			{
				choice = "Toggle REPL",
				func = function()
					require("dap").repl.toggle()
				end,
			},
			{
				choice = "Toggle DAP UI",
				func = function()
					require("dapui").toggle()
				end,
			},
		})
	end)
	utils.keymap("n", "<c-s-/>", ":FzfLua resume<cr>")
	utils.keymap("n", "g/", ":FzfLuaSearch<cr>")
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
	theme.set_hl("FzfLuaCursorLine", { bg = 4, fg = theme.blender.fg_darker_1 })
	theme.set_hl("FzfLuaCursorLineNr", { bg = 4, fg = theme.blender.fg_darker_1 })
	fzf.register_ui_select()
end

return M
