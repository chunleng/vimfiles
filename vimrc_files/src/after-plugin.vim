nnoremap <silent><esc> :nohl<cr>

nnoremap <silent><leader>tl :set list!<cr>
nnoremap <silent><leader>tp :set paste!<cr>
nnoremap <silent><leader>tw :set wrap!<cr>
nnoremap <silent><leader>x :close!<cr>

nnoremap <silent><s-left> :leftabove vsplit<cr>
nnoremap <silent><s-right> :rightbelow vsplit<cr>
nnoremap <silent><s-up> :leftabove split<cr>
nnoremap <silent><s-down> :rightbelow split<cr>

nnoremap <silent>!% :source ~/.config/nvim/init.lua<cr>
nnoremap <silent>!rs :e ~/.slate<cr>
nnoremap <silent>!rv :e ~/.config/nvim/init.lua<cr>
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

augroup ecmascript
  autocmd!
  " Add missing information for jsx and tsx
  autocmd FileType typescriptreact set indentexpr=GetTypescriptIndent()
  autocmd FileType javascriptreact set indentexpr=GetJavascriptIndent()
augroup END

augroup gitcommit
    autocmd!
    " Syntax highlight should be fixed by this PR? (Awaiting release)
    " https://github.com/neovim/neovim/pull/17007
    autocmd FileType gitcommit set comments=:;
    autocmd FileType gitcommit set commentstring=;\ %s
augroup END
