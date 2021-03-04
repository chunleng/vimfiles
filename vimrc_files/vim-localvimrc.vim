" Vim localvimrc
nnoremap !rV :e vimrc<cr>
let g:localvimrc_name = ["vimrc"]

let g:localvimrc_file_directory_only = 0

" Disable sandbox to enable running of autocmd
" NOTE: do not remove ask, only accept if you know the content of vimrc
let g:localvimrc_sandbox = 0
let g:localvimrc_ask = 1

" Store decision to source local vimrc
let g:localvimrc_persistent = 2
