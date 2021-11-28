let g:coc_fzf_opts = ['--layout=reverse']
let g:coc_fzf_preview = 'right:50%'
let g:coc_fzf_preview_toggle_key = 'ctrl-/'

" Code Diagnostic
nnoremap <silent><leader>c? :CocFzfList diagnostics<cr>
nnoremap <silent><leader>cd :CocFzfList diagnostics --current-buf<cr>

" Code Action
nnoremap <silent><leader>ca :CocFzfList actions<cr>
