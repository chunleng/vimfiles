local M = {}

function M.setup()
	local theme = require("common-theme")

	theme.set_hl("InclineNormal", { fg = 0, bg = 6 })
	theme.set_hl("InclineNormalNc", {
		fg = theme.blender.fg_darker_3,
		bg = theme.blender.bg_lighter_2,
	})

	require("incline").setup({
		render = function(props)
			local bufname = vim.api.nvim_buf_get_name(props.buf)
			local f_name, f_extension = vim.fn.fnamemodify(bufname, ":t"), vim.fn.fnamemodify(bufname, ":e")
			local icon = require("nvim-web-devicons").get_icon(f_name, f_extension, { default = true })
			return icon .. " " .. f_name
		end,
		window = { margin = { vertical = 0 } },
		hide = { only_win = true },
	})
end

return M
