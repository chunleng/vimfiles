" Find files
nnoremap <silent><leader>sf :call fzf#vim#files('', {'options': ['--layout=reverse']})<cr>

" Ag
nnoremap <silent><leader>sa :exec "call fzf#vim#ag('".input("ag > ")."', fzf#vim#with_preview({'options': ['--layout=reverse']}), 0)"<cr>
nnoremap <silent><leader>su :call fzf#vim#ag(expand("<cword>"), fzf#vim#with_preview(), 0)<cr>

" Buffer
