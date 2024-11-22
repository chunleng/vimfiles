local M = {}

function M.setup()
	local utils = require("common-utils")
	utils.keymap("n", "<c-s-g>", function()
		utils.action_menu({
			{
				choice = "File Blame",
				func = function()
					vim.cmd("Git blame --date=short")
				end,
			},
			{
				choice = "File Log",
				func = function()
					vim.cmd("vert Git log %")
				end,
			},
		})
	end)

	vim.cmd([[
        augroup FugitiveFiletype
            autocmd!
            autocmd FileType fugitiveblame,git nnoremap <buffer> q <cmd>bd<cr>
            autocmd FileType fugitiveblame,git nnoremap <buffer> <c-s-g> <cmd>bd<cr>
            autocmd FileType fugitiveblame setlocal nolist
        augroup END
    ]])

	local theme = require("common-theme")
	theme.set_hl("FugitiveblameDelimiter", { fg = 0 })
	theme.set_hl("FugitiveblameUncommitted", { fg = 0 })
	theme.set_hl("gitIdentity", { fg = 2 })
	theme.set_hl("diffOldFile", { fg = theme.blender.fg_darker_3 })
	theme.set_hl("diffRemoved", { fg = theme.blender.fg_darker_3 })
	theme.set_hl("diffNewFile", { fg = theme.blender.add })
	theme.set_hl("diffAdded", { fg = theme.blender.add })
	theme.set_hl("diffFile", { fg = 4, bg = theme.blender.bg_lighter_1, bold = true })
	theme.set_hl("diffLine", { fg = 6, underline = true })
end

return M
