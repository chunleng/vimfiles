runtime config.vim

" Plugins config that has to be loaded before the plugin
runtime before-vim-polyglot.vim

call plug#begin('~/.vim/plugged')

" Allow to assign same key to navigate between vim and tmux pane
Plug 'christoomey/vim-tmux-navigator', { 'on': ['TmuxNavigateUp', 'TmuxNavigateDown', 'TmuxNavigateLeft', 'TmuxNavigateRight'] }

" Show the menu for leader key
Plug 'spinks/vim-leader-guide'

" File navigator & plugins
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Beautify
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Allow to view edit history
Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }
Plug 'Yggdroot/indentLine'
Plug 'AndrewRadev/linediff.vim', { 'on': 'Linediff' }

" Git integration
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'preservim/tagbar'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-obsession'
Plug 'embear/vim-localvimrc'

" Parentheses formatting
Plug 'cohama/lexima.vim'
Plug 'tpope/vim-commentary'
Plug 'itchyny/vim-cursorword'
Plug 'whatyouhide/vim-lengthmatters'
Plug 'tpope/vim-surround'
Plug 'qpkorr/vim-bufkill'
Plug 'sheerun/vim-polyglot'
Plug 'mattn/emmet-vim'
Plug 'neoclide/coc.nvim'
Plug 'git@bitbucket.org:chunleng/ultisnips-snippet.git'

" Fuzzy finder for files, grep and more
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

runtime rc.vim
runtime vim-tmux-navigator.vim
runtime vim-leader-guide.vim
runtime nerdtree.vim
runtime nerdtree-git-plugin.vim
runtime gundo.vim
runtime indentLine.vim
runtime linediff.vim
runtime vim-fugitive.vim
runtime vim-airline.vim
runtime vim-airline-themes.vim
runtime tagbar.vim
runtime ultisnips.vim
runtime coc.nvim.vim
runtime vim-localvimrc.vim
runtime vim-gitgutter.vim
runtime vim-lengthmatters.vim
runtime vim-bufkill.vim
runtime emmet-vim.vim
runtime fzf.vim

" mappings ----------------------------- {{{
nnoremap <silent><esc> :nohl<cr>
nnoremap <silent><c-n> :bn<cr>
nnoremap <silent><c-p> :bp<cr>
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
nnoremap <left> :leftabove vsplit<cr>
nnoremap <right> :rightbelow vsplit<cr>
nnoremap <up> :leftabove split<cr>
nnoremap <down> :rightbelow split<cr>
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
hi VertSplit cterm=NONE ctermfg=235 ctermbg=NONE
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
hi DiffText cterm=bold,underline ctermfg=25 ctermbg=NONE " Blue
hi EndOfBuffer ctermfg=Black ctermbg=Black
hi Folded cterm=bold ctermfg=243 ctermbg=235

"" Gutter
hi LineNr cterm=NONE ctermfg=237 ctermbg=NONE
hi CursorLineNr cterm=NONE ctermfg=240 ctermbg=NONE
hi SignColumn ctermbg=NONE
hi FoldColumn ctermfg=238 ctermbg=NONE
" }}}

augroup python
    autocmd!
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

