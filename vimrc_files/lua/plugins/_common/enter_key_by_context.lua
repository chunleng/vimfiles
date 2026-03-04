local utils = require("common-utils")
local ls = require("luasnip")
local blink = require("blink-cmp")

utils.keymap({ "i", "s" }, "<cr>", function()
	if ls.jumpable(1) then
		blink.hide()
		ls.jump(1)
	else
		local is_end_of_line = #vim.api.nvim_get_current_line() == vim.api.nvim_win_get_cursor(0)[2]
		if is_end_of_line and vim.o.filetype == "markdown" then
			vim.cmd("InsertNewBullet")
		else
			vim.fn.feedkeys(require("nvim-autopairs").autopairs_cr(), "n")
		end
	end
end)
return {}
