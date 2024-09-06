local M = {}

function M.setup()
	vim.cmd([[
		let g:test#echo_command = 0
		let g:test#preserve_screen = 1
		let g:test#strategy = "kitty"
	]])

	local utils = require("common-utils")
	utils.keymap("n", "<c-t>", function()
		vim.cmd([[:TestNearest]])
	end)
end

return M
