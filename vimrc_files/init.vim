runtime config.vim

let &runtimepath.=','.g:dein_install_path

if dein#load_state(g:dein_plugin_path)
    call dein#begin(g:dein_plugin_path)
    call dein#add(g:dein_install_path)

    call dein#add('christoomey/vim-tmux-navigator')
    call dein#add('hecal3/vim-leader-guide')
    call dein#add('ctrlpvim/ctrlp.vim')
    call dein#add('scrooloose/nerdtree')
    call dein#add('Xuyuanp/nerdtree-git-plugin')
    call dein#add('ryanoasis/vim-devicons')
    call dein#add('sjl/gundo.vim')
    call dein#add('Yggdroot/indentLine')
    call dein#add('AndrewRadev/linediff.vim')
    call dein#add('thinca/vim-quickrun', {'depends':'tyru/open-browser.vim'})
    call dein#add('tyru/open-browser.vim')
    call dein#add('tpope/vim-fugitive')
    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')
    call dein#add('vim-syntastic/syntastic')
    call dein#add('majutsushi/tagbar')
    call dein#add('SirVer/ultisnips')
    call dein#add('Shougo/deoplete.nvim')
    call dein#add('autozimu/LanguageClient-neovim', {'build':'bash install.sh'})
    call dein#add('Shougo/neco-syntax')
    call dein#add('tpope/vim-obsession')
    call dein#add('embear/vim-localvimrc')
    call dein#add('cohama/lexima.vim')
    call dein#add('mhinz/vim-grepper')
    call dein#add('tpope/vim-commentary')
    call dein#add('itchyny/vim-cursorword')
    call dein#add('airblade/vim-gitgutter')
    call dein#add('michaeljsmith/vim-indent-object')
    call dein#add('whatyouhide/vim-lengthmatters')
    call dein#add('terryma/vim-multiple-cursors')
    call dein#add('tpope/vim-surround')
    call dein#add('dhruvasagar/vim-table-mode')
    call dein#add('janko-m/vim-test')
    call dein#add('Shougo/neco-vim')
    call dein#add('qpkorr/vim-bufkill')
    call dein#add('Chiel92/vim-autoformat')
    call dein#add('sheerun/vim-polyglot')
    call dein#add('git@bitbucket.org:chunleng/ultisnips-snippet.git')

    call dein#end()
    call dein#save_state()
endif

runtime rc.vim
runtime vim-tmux-navigator.vim
runtime vim-leader-guide.vim
runtime ctrlp.vim
runtime nerdtree.vim
runtime nerdtree-git-plugin.vim
runtime gundo.vim
runtime indentline.vim
runtime vim-quickrun.vim
runtime vim-fugitive.vim
runtime vim-airline.vim
runtime vim-airline-themes.vim
runtime vim-syntastic.vim
runtime tagbar.vim
runtime ultisnips.vim
runtime deoplete.vim
runtime languageclient-neovim.vim
runtime neco-syntax.vim
runtime vim-obssesion.vim
runtime vim-localvimrc.vim
runtime vim-gitgutter.vim
runtime vim-lengthmatters.vim
runtime vim-multiple-cursors.vim
runtime vim-table-mode.vim
runtime vim-test.vim
runtime vim-autoformat.vim

" mappings ----------------------------- {{{
noremap <silent><leader>bd :<c-u>BD!<cr>
nnoremap <silent><esc> :nohl<cr>
nnoremap <silent><c-n> :bn<cr>
nnoremap <silent><c-p> :bp<cr>
"" Difference <leader>d
vmap <leader>d :Linediff<cr>
"" Format <leader>f
nnoremap <leader>fi gg=G``
vnoremap <leader>fi =
"" Toggle <leader>t
nnoremap <leader>tl :set list!<cr>
nnoremap <leader>tp :set paste!<cr>
nnoremap <leader>tw :set wrap!<cr>
"" Close Tab <leader>x
nnoremap <leader>x :close!<cr>
"" Mapping mac keys to the appropriate function
nnoremap <left> :vsp<cr><c-w><left>
nnoremap <right> :vsp<cr>
nnoremap <up> :sp<cr><c-w><up>
nnoremap <down> :sp<cr>
"" Important Files
nnoremap !% :source ~/.config/nvim/init.vim<cr>
nnoremap !rv :e ~/.config/nvim/init.vim<cr>
nnoremap !rt :e ~/.tmux.conf<cr>
nnoremap !rz :e ~/.zshrc<cr>
"" Braces Function
nnoremap <silent> [<cr>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap <silent> ]<cr>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>
" }}}

"alphsubs ---------------------- {{{
execute "digraphs ks " . 0x2096
execute "digraphs as " . 0x2090
execute "digraphs es " . 0x2091
execute "digraphs hs " . 0x2095
execute "digraphs is " . 0x1D62
execute "digraphs ks " . 0x2096
execute "digraphs ls " . 0x2097
execute "digraphs ms " . 0x2098
execute "digraphs ns " . 0x2099
execute "digraphs os " . 0x2092
execute "digraphs ps " . 0x209A
execute "digraphs rs " . 0x1D63
execute "digraphs ss " . 0x209B
execute "digraphs ts " . 0x209C
execute "digraphs us " . 0x1D64
execute "digraphs vs " . 0x1D65
execute "digraphs xs " . 0x2093
"}}}

" highlight ------------------------------------------------- {{{
hi NonText ctermfg=236 ctermbg=black " Gray
hi Normal ctermfg=246 " White
hi NormalNC ctermfg=240 " White
hi Conceal cterm=NONE ctermfg=238 ctermbg=NONE " Gray
                    
"" Syntax
hi Comment cterm=NONE ctermfg=240 ctermbg=NONE " Gray
hi Constant cterm=italic ctermfg=NONE
hi Boolean cterm=bold ctermfg=NONE
hi Identifier ctermfg=209 " Orange
hi Statement cterm=bold ctermfg=24 " Blue
hi Operator cterm=italic ctermfg=24 " Blue
hi PreProc ctermfg=NONE
hi Include cterm=bold ctermfg=126 " VioletRed
hi Type ctermfg=35 " Green
hi Special cterm=italic ctermfg=240
hi Todo cterm=NONE ctermfg=Black ctermbg=Green

"" Other Visuals
hi Pmenu ctermfg=blue ctermbg=236 " Gray
hi PmenuThumb ctermbg=243
hi CursorLine cterm=NONE ctermbg=236 ctermfg=NONE
hi CursorColumn cterm=NONE ctermbg=236 ctermfg=NONE
hi MatchParen cterm=bold,underline ctermbg=NONE ctermfg=NONE
hi Visual ctermbg=236
hi StatusLine cterm=NONE ctermfg=243 ctermbg=NONE
hi StatusLineNC cterm=NONE ctermfg=236 ctermbg=NONE
hi Menu cterm=reverse
hi VertSplit cterm=bold ctermfg=243 ctermbg=NONE
hi Search cterm=NONE ctermfg=White ctermbg=NONE
hi IncSearch cterm=NONE ctermbg=White
hi SpellCap cterm=NONE ctermfg=Black ctermbg=Yellow
hi WarningMsg cterm=bold ctermfg=Yellow ctermbg=NONE
hi ErrorMsg cterm=bold ctermfg=Red ctermbg=None
hi SpellBad cterm=NONE ctermfg=White ctermbg=Red
hi QuickFixLine cterm=bold ctermfg=NONE ctermbg=NONE
hi DiffAdd cterm=NONE ctermfg=Green ctermbg=NONE " Green
hi DiffDelete cterm=NONE ctermfg=1 ctermbg=NONE " Red
hi DiffChange cterm=bold ctermfg=NONE ctermbg=NONE " Blue
hi DiffText cterm=bold,underline ctermfg=232 ctermbg=25 " Blue
hi EndOfBuffer ctermfg=Black ctermbg=Black
hi Folded cterm=bold ctermfg=243 ctermbg=235

"" Gutter
hi LineNr cterm=NONE ctermfg=237 ctermbg=NONE
hi CursorLineNr cterm=NONE ctermfg=240 ctermbg=NONE
hi GitGutterAddDefault ctermfg=2 ctermbg=NONE
hi GitGutterChangeDefault ctermfg=3 ctermbg=NONE
hi GitGutterDeleteDefault ctermfg=1 ctermbg=NONE
hi SignColumn ctermbg=NONE
hi FoldColumn ctermfg=238 ctermbg=NONE
" }}}

augroup python
    autocmd!
    autocmd FileType python setlocal keywordprg=":terminal pydoc"
    autocmd FileType python setlocal foldmethod=indent
augroup END

augroup vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

augroup markdown
    autocmd!
    autocmd FileType markdown setlocal noet
    autocmd FileType markdown setlocal shiftwidth=0
    autocmd FileType markdown setlocal softtabstop=0
augroup END

augroup snippet
    autocmd!
    autocmd FileType snippets setlocal noet
augroup END

" vi: et sw=4 sts=4 ts=4
