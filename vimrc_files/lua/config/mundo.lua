local M = {}

function M.setup()
	local utils = require("common-utils")
	utils.keymap("n", "<c-s-u>", "<cmd>MundoToggle<cr>")
	vim.g.mundo_width = 30
	vim.g.mundo_header = 0
end

return M
