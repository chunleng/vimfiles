nnoremap <silent><esc> :nohl<cr>

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

nnoremap <silent><c-l> <c-w>l
nnoremap <silent><c-h> <c-w>h
nnoremap <silent><c-j> <c-w>j
nnoremap <silent><c-k> <c-w>k

augroup vim
    autocmd!
    autocmd FileType,BufWinEnter vim setlocal foldmethod=marker
augroup END

augroup allfile
    " Contains configuration that I don't want the plugin to overwrite
    autocmd!
    " r,o: Continue comment
    " M,B: Don't insert space when joining Multibyte characters (e.g Chinese characters)
    " j: Remove comment leader when joining comment
    autocmd FileType,BufWinEnter * setlocal formatoptions=roMBj
augroup END

" Highlight Formatting ------------------------------------------------- {{{
hi NonText guifg=#333333 guibg=None

" Swap base16 tomorrow IncSearch and Search
hi Search guibg=#de935f
hi IncSearch guibg=#f0c674

"" Syntax
hi Comment gui=italic guifg=#777777 guibg=None

"" Other Visuals
hi MatchParen gui=bold,italic guibg=NONE guifg=NONE
hi StatusLine gui=NONE guifg=#333333 guibg=NONE
hi StatusLineNC gui=NONE guifg=#333333 guibg=NONE
hi VertSplit gui=NONE guifg=#333333 guibg=NONE
hi DiffAdd guifg=black guibg=green
hi DiffDelete guifg=black guibg=red
hi DiffChange gui=bold guifg=NONE guibg=NONE
hi DiffText gui=bold guifg=black guibg=blue

"" Gutter
hi LineNr guibg=NONE
hi CursorLineNr guibg=NONE
hi SignColumn guibg=NONE
hi FoldColumn guibg=NONE
" }}}
