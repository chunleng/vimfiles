local function setup()
	require("scrollbar").setup({
		set_highlights = false,
		excluded_filetypes = { "blink-cmp-menu", "blink-cmp-documentation" },
		marks = {
			Error = { text = { "🬇", "▐" } },
			Warn = { text = { "🬇", "▐" } },
			Info = { text = { "🬇", "▐" } },
			Hint = { text = { " ", " " } },
		},
		handlers = { cursor = false },
	})

	local theme = require("common-theme")
	theme.set_hl("ScrollbarHandle", { bg = theme.blender.scrollbar })
	theme.set_hl("ScrollbarError", { fg = theme.blender.error })
	theme.set_hl("ScrollbarErrorHandle", { fg = theme.blender.error, bg = theme.blender.scrollbar })
	theme.set_hl("ScrollbarWarn", { fg = theme.blender.warn })
	theme.set_hl("ScrollbarWarnHandle", { fg = theme.blender.warn, bg = theme.blender.scrollbar })
	theme.set_hl("ScrollbarInfo", { fg = theme.blender.info })
	theme.set_hl("ScrollbarInfoHandle", { fg = theme.blender.info, bg = theme.blender.scrollbar })
	-- theme.set_hl("ScrollbarHint", { fg = theme.blender.hint })
	theme.set_hl("ScrollbarHintHandle", { fg = theme.blender.scrollbar, bg = theme.blender.scrollbar })
end

return {
	{
		-- https://github.com/petertriho/nvim-scrollbar
		"petertriho/nvim-scrollbar",
		config = setup,
	},
}
