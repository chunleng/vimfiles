local function setup()
	local gl = require("galaxyline")
	local condition = require("galaxyline.condition")
	local navic = require("nvim-navic")
	local gls = gl.section
	local theme = require("common-theme")
	local utils = require("common-utils")
	local codecompanion = require("codecompanion")

	local count_diagnostic = function(type)
		return #vim.diagnostic.get(nil, { severity = vim.diagnostic.severity[type] })
	end

	navic.setup({ lsp = { auto_attach = true }, icons = utils.kind_icons })

	-- theme.set_hl(name, options)
	theme.set_hl("GalaxylineDiagnosticError", { fg = 0, bg = theme.blender.error })
	theme.set_hl("GalaxylineDiagnosticWarn", { fg = 0, bg = theme.blender.warn })
	theme.set_hl("GalaxylineGit", {
		fg = theme.blender.bg_lighter_3,
		bg = theme.blender.bg_lighter_1,
	})
	theme.set_hl("GalaxylineLineInfo", {
		fg = theme.blender.fg_darker_3,
		bg = theme.blender.bg_lighter_1,
	})
	theme.set_hl("GalaxylineFileFormat", {
		fg = theme.blender.bg_lighter_3,
		bg = theme.blender.bg_lighter_1,
	})

	gls.left = {
		{
			Space = {
				provider = function()
					return nil
				end,
				separator = " ",
				separator_highlight = "StatusLine",
			},
		},
		{
			LspError = {
				provider = function()
					return string.format("  %s ", tostring(count_diagnostic("ERROR")))
				end,
				highlight = "GalaxylineDiagnosticError",
				separator = " ",
				separator_highlight = "StatusLine",
				condition = function()
					return count_diagnostic("ERROR") > 0
				end,
			},
		},
		{
			LspWarn = {
				provider = function()
					return string.format("  %s ", tostring(count_diagnostic("WARN")))
				end,
				highlight = "GalaxylineDiagnosticWarn",
				separator = " ",
				separator_highlight = "StatusLine",
				condition = function()
					return count_diagnostic("WARN") > 0
				end,
			},
		},
		{
			CodeCompanionChatTitle = {
				provider = function()
					if vim.o.ft ~= "codecompanion" then
						return ""
					end

					local current_chat = vim.tbl_filter(function(x)
						return x.chat.bufnr == vim.api.nvim_get_current_buf()
					end, codecompanion.buf_get_chat())[1]
					local adapter_name = current_chat.chat.adapter.name
					local model_name = current_chat.chat.adapter.model.name
					return current_chat
							and "󰭻 " .. adapter_name .. "|" .. model_name .. ": " .. current_chat.description
						or ""
				end,
			},
		},
		{
			nvimNavic = {
				provider = function()
					return navic.get_location()
				end,
				condition = function()
					return navic.is_available()
				end,
				highlight = "StatusLine",
			},
		},
	}

	gls.right = {
		{
			LineColumn = {
				provider = function()
					return string.format("%2d/%d  %-2d", vim.fn.line("."), vim.fn.line("$"), vim.fn.col("."))
				end,
				highlight = "GalaxylineLineInfo",
			},
		},
		{
			FileType = {
				provider = function()
					return vim.o.filetype
				end,
				condition = condition.hide_in_width,
				separator = " ",
				separator_highlight = "StatusLine",
				highlight = "GalaxylineFileFormat",
			},
		},
		{
			FileEncode = {
				provider = "FileEncode",
				condition = condition.hide_in_width,
				separator = " ",
				separator_highlight = "StatusLine",
				highlight = "GalaxylineFileFormat",
			},
		},
		{
			FileFormat = {
				provider = "FileFormat",
				condition = condition.hide_in_width,
				separator = " ",
				separator_highlight = "StatusLine",
				highlight = "GalaxylineFileFormat",
			},
		},
		{
			GitBranch = {
				provider = "GitBranch",
				condition = condition.check_git_workspace,
				icon = " ",
				separator = " ",
				separator_highlight = "StatusLine",
				highlight = "GalaxylineGit",
			},
		},
		{
			Space = {
				provider = function()
					return nil
				end,
				separator = " ",
				separator_highlight = "StatusLine",
			},
		},
	}
end

return {
	{
		-- https://github.com/glepnir/galaxyline.nvim
		-- https://github.com/SmiteshP/nvim-navic
		-- https://github.com/olimorris/codecompanion.nvim
		"glepnir/galaxyline.nvim",
		dependencies = { "SmiteshP/nvim-navic", "olimorris/codecompanion.nvim" },
		config = setup,
	},
}
