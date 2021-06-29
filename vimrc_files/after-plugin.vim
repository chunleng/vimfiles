nmap <silent><esc> :nohl<cr>:call minimap#vim#ClearColorSearch()<cr>

nnoremap <silent><c-n> :bn<cr>
nnoremap <silent><c-p> :bp<cr>

nnoremap <silent><leader>tl :set list!<cr>
nnoremap <silent><leader>tp :set paste!<cr>
nnoremap <silent><leader>tw :set wrap!<cr>
nnoremap <silent><leader>x :close!<cr>

nnoremap <silent><s-left> :leftabove vsplit<cr>
nnoremap <silent><s-right> :rightbelow vsplit<cr>
nnoremap <silent><s-up> :leftabove split<cr>
nnoremap <silent><s-down> :rightbelow split<cr>

nnoremap <silent>!% :source ~/.config/nvim/init.vim<cr>
nnoremap <silent>!rs :e ~/.slate<cr>
nnoremap <silent>!rv :e ~/.config/nvim/init.vim<cr>
nnoremap <silent>!rk :e ~/.config/kitty/kitty.conf<cr>
nnoremap <silent>!rz :e ~/.zshrc<cr>

nnoremap <silent> [<cr>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap <silent> ]<cr>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>

nnoremap <silent><c-l> <c-w>l
nnoremap <silent><c-h> <c-w>h
nnoremap <silent><c-j> <c-w>j
nnoremap <silent><c-k> <c-w>k

augroup vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" r,o: Continue comment
" M,B: Don't insert space when joining Multibyte characters (e.g Chinese characters)
" j: Remove comment leader when joining comment
autocmd FileType * set formatoptions=roMBj
