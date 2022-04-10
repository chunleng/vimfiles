local M = {}

function M.setup()
    vim.cmd [[
	augroup sleuth
	    autocmd!
	    autocmd FileType snippets let b:sleuth_automatic = 0
	augroup END
    ]]
end

return M
