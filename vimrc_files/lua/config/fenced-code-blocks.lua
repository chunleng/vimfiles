local M = {}

function M.setup()
	vim.cmd([[
    augroup fenced_code_block
        autocmd!
        autocmd FileType markdown nnoremap <buffer> <silent> <leader>cgf :E<cr>
    augroup END
    ]])
end

return M
