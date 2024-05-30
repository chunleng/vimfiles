local M = {}

function M.setup()
	vim.cmd([[
        augroup vim_rails
            autocmd!
            " <leader>cga does a collection of useful goto
            autocmd FileType ruby nnoremap <buffer> <silent> <leader>cga <cmd>Econtroller<cr>:Emodel<cr>:Ehelper<cr>
            " <leader>cgt goes to related test
            autocmd FileType ruby nnoremap <buffer> <silent> <leader>cgt <cmd>A<cr>
            autocmd FileType ruby nnoremap <buffer> <silent> <leader>cgv <cmd>Eview<cr>
            autocmd FileType ruby nnoremap <buffer> <silent> <leader>cgc <cmd>Econtroller<cr>
            autocmd FileType ruby nnoremap <buffer> <silent> <leader>cgm <cmd>Emodel<cr>
            autocmd FileType ruby nnoremap <buffer> <silent> <leader>cgh <cmd>Ehelper<cr>
            autocmd FileType ruby nnoremap <buffer> <silent> <leader>cgds <cmd>Eschema<cr>
            autocmd FileType ruby nnoremap <buffer> <silent> <leader>cgdm <cmd>Emigration<cr>
        augroup END
    ]])
end

return M
