-- Keeping filetype to codecompanion because I need to read more than I write on it
local ft = { "codecompanion" }
return {
	-- https://github.com/MeanderingProgrammer/render-markdown.nvim.git
	"MeanderingProgrammer/render-markdown.nvim",
	config = function()
		require("render-markdown").setup({
			nested = false,
			file_types = ft,
			anti_conceal = {
				disabled_modes = { "n" },
				below = 10,
				ignore = {
					code_border = false,
				},
			},
			heading = {
				icons = { "█ ", "██ ", "█ ", "▋ ", "▋ ", " " },
			},
			code = {
				language_pad = 2,
				border = "thin",
			},
		})

		local theme = require("common-theme")
		theme.set_hl("RenderMarkdownH1Bg", { bg = theme.blender.bg_lighter_2, fg = 14, bold = true })
		theme.set_hl("RenderMarkdownH2Bg", { bg = theme.blender.bg_lighter_1, fg = 25, bold = true })
		theme.set_hl("RenderMarkdownH3Bg", { fg = 24, bold = true })
		theme.set_hl("RenderMarkdownH4Bg", { fg = 24, bold = true })
		theme.set_hl("RenderMarkdownH5Bg", { fg = 24, bold = true })
		theme.set_hl("RenderMarkdownH6Bg", { fg = 24, bold = true })
		theme.set_hl("RenderMarkdownH6Bg", { fg = 24, bold = true })
		theme.set_hl("RenderMarkdownCode", { bg = theme.blender.bg_darker_2 })
	end,
	ft = ft,
}
