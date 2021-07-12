let g:test#strategy = 'kitty'
let g:test#preserve_screen = 1

nnoremap <silent><leader>ctf :TestFile<cr>
nnoremap <silent><leader>ctn :TestNearest<cr>
nnoremap <silent><leader>ctt :TestSuite<cr>
