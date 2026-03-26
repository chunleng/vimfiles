local lualine_constants = require("mod.global_constants").lualine

local function setup()
	local codecompanion = require("codecompanion")
	local navic = require("nvim-navic")
	local theme = require("common-theme")
	local utils = require("common-utils")

	navic.setup({ lsp = { auto_attach = true }, icons = utils.kind_icons })

	local plain_theme_section = {
		a = { bg = theme.blender.bg_lighter_1, fg = theme.blender.bg_lighter_3 },
		b = { bg = theme.blender.bg_lighter_1, fg = theme.blender.fg_darker_3 },
		c = { theme.blender.bg_lighter_1, fg = theme.blender.fg_darker_1 },
	}
	require("lualine").setup({
		options = {
			theme = {
				normal = plain_theme_section,
				insert = plain_theme_section,
				visual = plain_theme_section,
				replace = plain_theme_section,
				inactive = plain_theme_section,
			},
			section_separators = "",
			component_separators = "",
			globalstatus = true,
		},
		sections = {
			lualine_a = {
				{
					"diagnostics",
					sources = { "nvim_workspace_diagnostic" },
					sections = { "error", "warn" },
					symbols = { error = " ", warn = " " },
					diagnostics_color = {
						error = "DiagnosticError",
						warn = "DiagnosticWarn",
					},
				},
			},
			lualine_b = {},
			lualine_c = {
				function()
					if vim.o.ft ~= "codecompanion" then
						return ""
					end

					local current_chat = vim.tbl_filter(function(x)
						return x.chat.bufnr == vim.api.nvim_get_current_buf()
					end, codecompanion.buf_get_chat())[1]

					if current_chat == nil then
						return ""
					end

					local adapter_name = current_chat.chat.adapter.name
					local model_name = current_chat.chat.adapter.schema.model.default
					return current_chat
							and "󰭻 " .. adapter_name .. "|" .. (model_name or "") .. ": " .. current_chat.description
						or ""
				end,
				function()
					return navic.get_location()
				end,
			},
			lualine_x = {
				require("codecompanion._extensions.spinner.styles.lualine").get_lualine_component(),
				lualine_constants.additional_status,
			},
			lualine_y = {
				{
					"lsp_status",
					symbols = { spinner = { " " }, done = "", separator = "|" },
					color = { fg = theme.blender.bg_lighter_3 },
				},
				function()
					return string.format("%2d/%d  %-2d", vim.fn.line("."), vim.fn.line("$"), vim.fn.col("."))
				end,
			},
			lualine_z = {
				"bo:filetype",
				function()
					return vim.bo.fileformat:upper()
				end,
				function()
					return vim.bo.fileencoding:upper()
				end,
			},
		},
	})
end

return {
	{
		-- https://github.com/nvim-lualine/lualine.nvim
		-- https://github.com/SmiteshP/nvim-navic
		-- https://github.com/olimorris/codecompanion.nvim
		"nvim-lualine/lualine.nvim",
		dependencies = { "SmiteshP/nvim-navic", "olimorris/codecompanion.nvim" },
		config = setup,
	},
}
