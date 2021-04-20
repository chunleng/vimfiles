let g:gitgutter_map_keys = 0
nnoremap <leader>gn :GitGutterNextHunk<cr>
nnoremap <leader>gp :GitGutterPrevHunk<cr>
let g:gitgutter_sign_added = ''
let g:gitgutter_sign_modified = ''
let g:gitgutter_sign_removed = ''
let g:gitgutter_sign_removed_first_line = ''
let g:gitgutter_sign_modified_removed = ''

" Lower priority for other signs
let g:gitgutter_sign_priority= 1


"""""""""""""
"  Display  "
"""""""""""""

hi GitGutterAdd ctermfg=22 ctermbg=NONE
hi GitGutterChange ctermfg=25 ctermbg=NONE
hi GitGutterDelete ctermfg=89 ctermbg=NONE
hi GitGutterChangeDelete ctermfg=89 ctermbg=NONE
