local utils = require("common-utils")
local tree_api = require("nvim-tree.api")

-- Customize Goto File feature
utils.keymap("n", "gf", function()
	local path = vim.fn.expand("<cfile>")

	if not path:match("^/") then
		path = vim.fn.expand("%:h") .. "/" .. path
	end

	if vim.fn.filereadable(path) == 1 then
		vim.cmd(":e " .. path)
	elseif vim.fn.isdirectory(path) == 1 then
		tree_api.tree.open()
		tree_api.tree.find_file(path)
	else
		local response = vim.fn.confirm('Create "' .. path .. '"?')
		if response == 1 then
			vim.cmd(":e " .. path)
		end
	end
end)
-- utils.keymap("x", "gf", "<cmd>e %:h/<cword><cr>")

return {}
