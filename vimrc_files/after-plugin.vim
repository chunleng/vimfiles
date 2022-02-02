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

augroup allfile
    autocmd!
    " BufWinEnter here is to override plugin that force the option
    " r,o: Continue comment
    " M,B: Don't insert space when joining Multibyte characters (e.g Chinese characters)
    " j: Remove comment leader when joining comment
    " q: Allow to use gq to format the selected block in visual mode
    " c: Autowrap comment
    " l: Don't autowrap if the line is already longer than text width
    autocmd BufWinEnter * setlocal formatoptions=roMBjqcl
augroup END

augroup vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

augroup markdown
    autocmd!
    " Set textwidth-related formatoptions
    " t: Autowrap text/code
    autocmd BufWinEnter *.md setlocal formatoptions+=t

    " Allow bullet points or quote format to continue on line break
    " + shift-enter to not continue
    autocmd FileType markdown setlocal comments=fb:*,fb:-,fb:+,n:>,fb:1.

    " Shorten textwidth to markdown standard
    autocmd FileType markdown setlocal textwidth=80

    " Allow spelling on markdown
    autocmd FileType markdown setlocal spell
augroup END

augroup snippets
    autocmd!
    autocmd FileType snippets setlocal foldlevel=0
augroup END

" Highlight Formatting ------------------------------------------------- {{{
exec "hi NonText guifg=#".g:base16_gui02." guibg=None"

" Swap base16 tomorrow IncSearch and Search
exec "hi Search guibg=#".g:base16_gui09
exec "hi IncSearch guibg=#".g:base16_gui0A

"" Syntax
exec "hi Comment gui=italic guifg=#".g:base16_gui03." guibg=None"

"" Other Visuals
hi MatchParen gui=bold,italic guibg=NONE guifg=NONE
exec "hi StatusLine gui=NONE guifg=#".g:base16_gui02." guibg=None"
exec "hi StatusLineNC gui=NONE guifg=#".g:base16_gui02." guibg=None"
exec "hi VertSplit gui=NONE guifg=#".g:base16_gui02." guibg=None"
exec "hi DiffAdd gui=NONE guifg=NONE guibg=NONE"
exec "hi DiffDelete gui=NONE guifg=#".g:base16_gui01." guibg=#".g:base16_gui01
exec "hi DiffText gui=undercurl guifg=#".g:base16_gui00." guibg=#".g:base16_gui0D

"" Gutter
hi LineNr guibg=NONE
hi CursorLineNr guibg=NONE
hi SignColumn guibg=NONE
hi FoldColumn guibg=NONE
" }}}
