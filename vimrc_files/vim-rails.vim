augroup vim_rails
    autocmd!
    " <leader>cga does a collection of useful goto
    autocmd FileType ruby nnoremap <buffer> <silent> <leader>cga :Econtroller<cr>:Emodel<cr>:Ehelper<cr>
    " <leader>cgt goes to related test
    autocmd FileType ruby nnoremap <buffer> <silent> <leader>cgt :A<cr>
    autocmd FileType ruby nnoremap <buffer> <silent> <leader>cgv :Eview<cr>
    autocmd FileType ruby nnoremap <buffer> <silent> <leader>cgc :Econtroller<cr>
    autocmd FileType ruby nnoremap <buffer> <silent> <leader>cgm :Emodel<cr>
    autocmd FileType ruby nnoremap <buffer> <silent> <leader>cgh :Ehelper<cr>
    autocmd FileType ruby nnoremap <buffer> <silent> <leader>cgds :Eschema<cr>
    autocmd FileType ruby nnoremap <buffer> <silent> <leader>cgdm :Emigration<cr>
augroup END
