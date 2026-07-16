local utils = require("common-utils")
local tree_api = require("nvim-tree.api")

-- Open a file path, respecting winfixbuf: if the current window has
-- winfixbuf set, find the first window without it; if none exists, split.
local function open_path(path)
	if not vim.wo.winfixbuf then
		vim.cmd(":e " .. path)
		return
	end

	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if not vim.wo[win].winfixbuf then
			vim.api.nvim_set_current_win(win)
			vim.cmd(":e " .. path)
			return
		end
	end

	vim.cmd("vsplit " .. path)
end

-- Custom gf that opens files via :e, directories in nvim-tree,
-- and prompts to create non-existent paths.
local function goto_file()
	local mode = vim.fn.mode()
	local path
	if mode:match("^[vV]") or mode == "\22" then
		local region = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."))
		path = table.concat(region, "\n")
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "x", false)
	else
		path = vim.fn.expand("<cfile>")
	end

	if not path:match("^/") then
		local base = vim.api.nvim_buf_get_name(0) ~= "" and vim.fn.expand("%:h") or vim.fn.getcwd()
		path = base .. "/" .. path
	end

	if vim.fn.filereadable(path) == 1 then
		open_path(path)
	elseif vim.fn.isdirectory(path) == 1 then
		tree_api.tree.open()
		tree_api.tree.find_file(path)
	else
		local response = vim.fn.confirm('Create "' .. path .. '"?')
		if response == 1 then
			open_path(path)
		end
	end
end

utils.keymap({ "n", "x" }, "gf", goto_file)

return {}
