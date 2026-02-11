local function setup()
	vim.g.extra_whitespace_ignored_filetypes = {
		"Mundo",
		"MundoDiff",
		"aerial",
		"dashboard",
		"dbout",
		"dbui",
		"fzf",
		"lspinfo",
		"help",
		"mason",
		"",
		"fugitiveblame",
		"git",
	}

	local theme = require("common-theme")
	theme.set_hl("ExtraWhitespace", { fg = 3, bold = true, bg = theme.blender.bg_lighter_2 })
end

return {
	{
		-- https://github.com/bronson/vim-trailing-whitespace
		"bronson/vim-trailing-whitespace",
		config = setup,
	},
}
