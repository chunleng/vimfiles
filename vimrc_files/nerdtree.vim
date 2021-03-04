nnoremap <leader><space> :NERDTreeToggle<cr>

let g:NERDTreeMinimalUI=1
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeAutoDeleteBuffer=1

augroup nerdtree
    autocmd!
    autocmd FileType nerdtree setlocal nolist
augroup END
