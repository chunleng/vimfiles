local M = {}

local indent_char = "│"

local function setup_better_tabspace()
	local group_name = "BetterTabspace"
	vim.api.nvim_create_augroup(group_name, { clear = true })
	vim.api.nvim_create_autocmd("VimEnter", {
		pattern = "*",
		callback = function()
			vim.opt.listchars:append({ tab = "  " })
			vim.opt.listchars:append({ lead = " " })
		end,
	})
	vim.api.nvim_create_autocmd({ "BufEnter", "BufNew", "InsertLeave" }, {
		pattern = "*",
		callback = function()
			local space, tab
			if vim.bo.expandtab then
				space = " "
				tab = "⇥"
			else
				space = "·"
				tab = indent_char
			end
			vim.wo.listchars =
				vim.wo.listchars:gsub("tab:[^,]+", "tab:" .. tab .. " "):gsub("lead:[^,]+", "lead:" .. space)
		end,
		group = group_name,
	})
end

local function setup_indent_line()
	vim.g.indentLine_defaultGroup = "Whitespace"
	vim.g.indentLine_char = indent_char
	vim.g.indentLine_fileTypeExclude = {
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
	}
end

function M.setup()
	setup_indent_line()
	setup_better_tabspace()
end

return M
