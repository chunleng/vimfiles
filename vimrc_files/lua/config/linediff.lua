local M = {}

function M.setup()
	local utils = require("common-utils")
	-- :Linediff<cr> not <cmd> because we want to pick up the range
	utils.keymap("x", "<leader>d", ":Linediff<cr>")
end

return M
