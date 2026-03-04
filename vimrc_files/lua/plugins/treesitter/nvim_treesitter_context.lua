local function setup()
	require("treesitter-context").setup({ max_lines = 3 })
	local theme = require("common-theme")
	theme.set_hl("TreesitterContext", { link = "Folded" })
	theme.set_hl("TreesitterContextLineNumber", { fg = theme.blender.fg_darker_3, bg = 0 })
end

return {
	-- https://github.com/nvim-treesitter/nvim-treesitter-context
	"nvim-treesitter/nvim-treesitter-context",
	config = setup,
}
