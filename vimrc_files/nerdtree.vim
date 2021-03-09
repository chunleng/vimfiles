nnoremap <leader><space> :NERDTreeToggle<cr>

let g:NERDTreeMinimalUI=1
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeAutoDeleteBuffer=1

let g:NERDTreeMapJumpFirstChild = 'gk'
let g:NERDTreeMapJumpLastChild = 'gj'
let g:NERDTreeMapJumpPrevSibling = 'K'
let g:NERDTreeMapJumpNextSibling = 'J'

augroup nerdtree
    autocmd!
    autocmd FileType nerdtree setlocal nolist
augroup END
