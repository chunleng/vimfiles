let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
let g:fzf_preview_window = ['right:50%', 'ctrl-/']

" Find files
nnoremap <silent><leader>sf :call fzf#vim#files('', fzf#vim#with_preview({'options': ['--layout=reverse']}))<cr>

" " Ag
nnoremap <silent><leader>sa :exec "call fzf#vim#ag('".input("ag > ")."', fzf#vim#with_preview({'options': ['--layout=reverse']}), 0)"<cr>
nnoremap <silent><leader>su :call fzf#vim#ag(expand('<cword>'), fzf#vim#with_preview({'options': ['--layout=reverse']}))<cr>

" " Buffer
nnoremap <silent><leader>bb :call fzf#vim#buffers('', {'options': ['--layout=reverse']})<cr>
