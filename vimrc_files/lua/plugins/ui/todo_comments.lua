local function setup()
	local todo = require("todo-comments")
	todo.setup({
		signs = false,
		highlight = {
			after = "",
		},
	})

	local utils = require("common-utils")
	utils.keymap("n", "<c-s-f>", "<cmd>TodoQuickFix<cr>")
end
return {
	-- https://github.com/folke/todo-comments.nvim
	"folke/todo-comments.nvim",
	config = setup,
}
