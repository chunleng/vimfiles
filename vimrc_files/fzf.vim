let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
let g:fzf_preview_window = ['right:50%', 'ctrl-/']
let g:default_layout = {'options': ['--layout=reverse', '--preview-window=']}
let g:default_layout_with_preview = {'options': ['--layout=reverse']}

" Find files
nnoremap <silent><leader>sf :call fzf#vim#files('', fzf#vim#with_preview(g:default_layout_with_preview))<cr>

" Ag
nnoremap <silent><leader>sa :exec "call fzf#vim#ag('".input("ag > ")."', fzf#vim#with_preview(g:default_layout_with_preview),0)"<cr>
nnoremap <silent><leader>su :call fzf#vim#ag(expand('<cword>'), fzf#vim#with_preview(g:default_layout_with_preview))<cr>

" Buffer
nnoremap <silent><leader>bb :call fzf#vim#buffers('', fzf#vim#with_preview(g:default_layout_with_preview))<cr>

" Git Conflict List
nnoremap <silent><leader>gc :call fzf#vim#buffers('', fzf#vim#with_preview(g:default_layout_with_preview))<cr>

" Show all commands
nnoremap <silent><leader>? :call fzf#vim#commands(g:default_layout)<cr>
