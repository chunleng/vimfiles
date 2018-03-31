set shell=/bin/bash

" Set Neovim's Python
let g:python_host_prog='/usr/local/base/homebrew/bin/python2'
let g:python3_host_prog='/usr/local/base/homebrew/bin/python3'

set runtimepath+=/usr/local/base/dein.vim/

if dein#load_state("~/.base/install/dein.plugin")
    call dein#begin("~/.base/install/dein.plugin")

    call dein#add("/usr/local/base/dein.vim/")
    call dein#add("christoomey/vim-tmux-navigator")
    call dein#add("hecal3/vim-leader-guide")
    call dein#add("ctrlpvim/ctrlp.vim")
    call dein#add("scrooloose/nerdtree")
    call dein#add("Xuyuanp/nerdtree-git-plugin")
    call dein#add("ryanoasis/vim-devicons")
    call dein#add("sjl/gundo.vim")
    call dein#add("Yggdroot/indentLine")
    call dein#add("AndrewRadev/linediff.vim")
    call dein#add("thinca/vim-quickrun")
    call dein#add("tyru/open-browser.vim")
    call dein#add("vim-pandoc/vim-pandoc")
    call dein#add("tpope/vim-fugitive")
    call dein#add("tpope/vim-endwise")
    call dein#add("vim-airline/vim-airline")
    call dein#add("vim-airline/vim-airline-themes")
    call dein#add("vim-syntastic/syntastic")
    call dein#add("godlygeek/tabular")
    call dein#add("majutsushi/tagbar")
    call dein#add("SirVer/ultisnips")
    call dein#add("Shougo/deoplete.nvim")
    call dein#add("autozimu/LanguageClient-neovim")
    call dein#add("Shougo/neco-syntax")
    " call dein#add("gioele/vim-autoswap")
    call dein#add("tpope/vim-obsession")
    call dein#add("embear/vim-localvimrc")
    call dein#add("jiangmiao/auto-pairs")
    call dein#add("mhinz/vim-grepper")
    call dein#add("tpope/vim-commentary")
    call dein#add("itchyny/vim-cursorword")
    call dein#add("airblade/vim-gitgutter")
    call dein#add("michaeljsmith/vim-indent-object")
    call dein#add("whatyouhide/vim-lengthmatters")
    call dein#add("terryma/vim-multiple-cursors")
    call dein#add("tpope/vim-surround")
    call dein#add("dhruvasagar/vim-table-mode")
    call dein#add("janko-m/vim-test")
    call dein#add("Shougo/neco-vim")
    call dein#add("diepm/vim-rest-console")
    call dein#add("qpkorr/vim-bufkill")
    call dein#add("Chiel92/vim-autoformat")
    call dein#add("sheerun/vim-polyglot")
    call dein#add("git@bitbucket.org:chunleng/ultisnips-snippet.git")

    call dein#end()
    call dein#save_state()
endif

" Default Vim
filetype plugin indent on
syntax enable
set mouse=n
nnoremap <LeftMouse> <Nop>
set number
set shiftwidth=4
set softtabstop=4
set tabstop=4
set autoindent
set expandtab
set smarttab
set nocompatible
set hidden
set relativenumber
set lazyredraw
set splitbelow
set splitright
set foldmethod=syntax
set foldlevelstart=99
noremap za :setlocal foldcolumn=3<cr>za
set formatoptions-=r
set formatoptions-=o
set complete=.,w
set completeopt-=preview
set sessionoptions+=resize,winpos
set list
set listchars=tab:»\ ,trail:·,extends:,precedes:,nbsp:+,eol:¶
set fillchars=vert:│,stlnc:-,diff:✕
set incsearch
set hlsearch
set laststatus=2
set wildmenu
set showcmd
set timeout ttimeout timeoutlen=3000 ttimeoutlen=1000
if has('nvim')
    set timeout ttimeout timeoutlen=3000 ttimeoutlen=-1
endif
set fileencodings=ucs-bom,utf-8,sjis,default
set synmaxcol=160
set textwidth=80
set nowrap
scriptencoding utf-8

" Allow more % start-end matching
if !exists('g:loaded_matchit')
    runtime macros/matchit.vim
endif

let g:mapleader="\<space>"

let g:lmap =  {}
let g:lmap.b = { 'name' : 'Buffer Menu' }
let g:lmap.c = { 'name' : 'Code Menu' }
let g:lmap.f = { 'name' : 'Format Menu' }
let g:lmap.g = { 'name' : 'Git Menu' }
let g:lmap.o = { 'name' : 'Original Mapping' }
let g:lmap.s = { 'name' : 'Search Menu' }
let g:lmap.t = { 'name' : 'Toggle Menu' }

call leaderGuide#register_prefix_descriptions("<Space>", "g:lmap")
nnoremap <leader> :<C-U>LeaderGuide ' '<CR>
nnoremap <leader>? :<C-U>LeaderGuide ' '<CR>
vnoremap <leader> :<C-U>LeaderGuideVisual ' '<CR>
vnoremap <leader>? :<C-U>LeaderGuideVisual ' '<CR>

" Shortkey Command
"" Buffer <leader>b
noremap <leader>bd :<c-u>BD!<cr>
noremap <leader>bw :<c-u>BW!<cr>
nnoremap <c-n> :bn<cr>
nnoremap <c-p> :bp<cr>
"" Code <leader>c
noremap <leader>ce :<c-u>call quickrun#run(g:quickrun_config)<cr>
noremap <leader>co :<c-u>Tagbar<cr>
""" <leader>cr refactor (See individual language)
noremap <leader>ct :<c-u>TestFile<cr>
nnoremap <leader>c< :Emmet
"" Difference <leader>d
nmap <leader>d :Gvdiff<cr>
vmap <leader>d :Linediff<cr>
"" Format <leader>f
nnoremap <leader>fi gg=G``
vnoremap <leader>fi =
nnoremap <leader>f<tab> :Tabularize /
"" Git Commands <leader>g
nnoremap <leader>g<space> :Gitv
nnoremap <leader>gd :Gvdiff<cr>
nnoremap <leader>gh :diffget //2<cr>:diffupdate<cr>
nnoremap <leader>gl :diffget //3<cr>:diffupdate<cr>
nnoremap <leader>gn :GitGutterNextHunk<cr>
nnoremap <leader>gp :GitGutterPrevHunk<cr>
"" Original Keyset <leader>o
nnoremap <leader>o<c-l> :redraw<cr>
"" Search <leader>s
nnoremap <leader><space> :NERDTreeToggle<cr>
nnoremap <leader>sa :Grepper<cr>
nnoremap <silent><leader>sf :CtrlP<cr>
nnoremap <leader>su "zyiw:Grepper -query <c-r>z<cr>
"" Toggle <leader>t
nnoremap <leader>tc :set cursorline! cursorcolumn!<cr>
nnoremap <leader>tg :GoldenRatioResize<cr>
nnoremap <leader>tl :set list!<cr>
nnoremap <leader>to :LengthmattersToggle<cr>
nnoremap <leader>tp :set paste!<cr>
nnoremap <leader>ts :Obsess!<cr>
nnoremap <leader>tt :TableModeToggle<cr>
nnoremap <leader>tw :set wrap!<cr>
"" Undo <leader>u
nnoremap <leader>u :GundoToggle<cr>
"" Close Tab <leader>x
nnoremap <leader>x :close!<cr>

" Replacement Map
" nnoremap <c-h> <c-w><left>
" nnoremap <c-l> <c-w><right>
" nnoremap <c-k> <c-w><up>
" nnoremap <c-j> <c-w><down>
let g:tmux_navigator_no_mappings=1
nnoremap <silent><c-h> :TmuxNavigateLeft<cr>
nnoremap <silent><c-l> :TmuxNavigateRight<cr>
nnoremap <silent><c-k> :TmuxNavigateUp<cr>
nnoremap <silent><c-j> :TmuxNavigateDown<cr>
"" Mapping mac keys to the appropriate function
nnoremap <left> :vsp<cr>
nnoremap <right> :vsp<cr><c-w><right>
nnoremap <up> :sp<cr>
nnoremap <down> :sp<cr><c-w><down>
"" Important Files
nnoremap !% :source ~/.config/nvim/init.vim<cr>
nnoremap !rv :e ~/.config/nvim/init.vim<cr>
nnoremap !rV :e vimrc<cr>
nnoremap !rt :e ~/.tmux.conf<cr>
nnoremap !rz :e ~/.zshrc<cr>
nnoremap !u :UltiSnipsEdit!<cr>
"" Braces Function
nnoremap <silent> [<cr>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap <silent> ]<cr>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>

set bg=dark
colorscheme default

" Nerd Tree
let g:NERDTreeMinimalUI=1
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeAutoDeleteBuffer=1
let g:NERDTreeShowLineNumbers=1
autocmd FileType nerdtree setlocal nolist

" Nerd Tree Git
let g:NERDTreeIndicatorMapCustom = {
            \ "Modified"  : "",
            \ "Staged"    : "",
            \ "Untracked" : "",
            \ "Renamed"   : "",
            \ "Unmerged"  : "",
            \ "Deleted"   : "",
            \ "Dirty"     : "(×)",
            \ "Clean"     : "(○)",
            \ "Unknown"   : ""
            \ }

" Airline
let g:airline_extensions = ['branch', 'tabline']
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#buffer_nr_show=1
let g:airline_theme='base16_tomorrow'

" Multiple Cursor
let g:multi_cursor_exit_from_insert_mode=0
let g:multi_cursor_start_key='\'

" Syntastic
let g:syntastic_error_symbol = ''
let g:syntastic_warning_symbol = ''

" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#enable_refresh_always = 1

call deoplete#custom#set('_', 'matchers', ['matcher_fuzzy'])
call deoplete#custom#set('ultisnips', 'matchers', ['matcher_full_fuzzy'])

" Ultisnips
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsSnippetsDir="/usr/local/base/dein.plugin/repos/bitbucket.org/chunleng/ultisnips-snippet/Ultisnips"

" Tabular
" More on ~/.vim/after/ftplugin/markdown.vim

" Tagbar
let g:tagbar_autoclose=1

" Gundo
let g:gundo_close_on_revert=1
let g:gundo_prefer_python3=1

" GitGutter
let g:gitgutter_sign_added = ''
let g:gitgutter_sign_modified = ''
let g:gitgutter_sign_removed = ''
let g:gitgutter_sign_removed_first_line = ''
let g:gitgutter_sign_modified_removed = ''

" CtrlP
let g:ctrlp_map = ''
let g:ctrlp_cmd = ''
let g:ctrlp_working_path_mode = 'w'
let g:ctrlp_prompt_mappings = {
            \ 'PrtSelectMove("j")':   ['<c-n>'],
            \ 'PrtSelectMove("k")':   ['<c-p>'],
            \ 'PrtHistory(-1)':       ['<down>'],
            \ 'PrtHistory(1)':        ['<up>']
            \}

" Devicon
let g:webdevicons_enable_airline_statusline = 0
let g:webdevicons_enable_ctrlp = 0
let g:WebDevIconsUnicodeDecorateFileNodes = 0

" Pandoc
let g:pandoc#keyboard#display_motions=0
" TODO sort plugin settings in alphabetical order
" TODO explore how to use this https://github.com/vim-scripts/dbext.vim

" QuickRun
let g:quickrun_config = {
            \ 'outputter/buffer/split': '',
            \ 'outputter/buffer/running_mark': 'Loading Execution...'
            \ }
let g:quickrun_config.html = {
            \ 'command': 'open',
            \ 'outputter': 'null'
            \ }
let g:quickrun_config.html = {
            \ 'command': 'cat %S',
            \ 'outputter': 'browser'
            \ }
let g:quickrun_config.markdown = {
            \ 'type': 'markdown/pandoc',
            \ 'cmdopt': '--toc -S -c ~/.base/new-workspace-config/etc/github-pandoc.css -s',
            \ 'outputter': 'browser'
            \ }
let g:quickrun_config.cheat = {
            \ 'type': 'markdown/pandoc',
            \ 'cmdopt': '-S -c ~/.base/new-workspace-config/etc/github-pandoc-cheatsheet.css -s',
            \ 'outputter': 'browser'
            \ }
let g:quickrun_config.matlab = {
            \ 'command': 'octave'
            \ }

" Lengthmatters
let g:lengthmatters_excluded=['unite', 'tagbar', 'startify', 'gundo', 'vimshell', 'w3m', 'nerdtree', 'help', 'qf', 'dirvish', 'leaderGuide']
call lengthmatters#highlight('ctermbg=1 ctermfg=15')

" IndentLine
let g:indentLine_char = '│'

autocmd FileType markdown setlocal noet
autocmd FileType markdown setlocal shiftwidth=0
autocmd FileType markdown setlocal softtabstop=0
autocmd FileType snippets setlocal noet

" Table Mode
let g:table_mode_corner_corner="+"
let g:table_mode_header_fillchar="="
let g:table_mode_map_prefix = "<leader>ft"

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


" Pandoc
let g:pandoc#filetypes#handled = ["markdown"]
let g:pandoc#filetypes#pandoc_markdown = 0
let g:pandoc#formatting#mode = "s"

" Rest-Console
autocmd FileType rest nnoremap <buffer> <leader>ce :call VrcQuery()<cr>
let g:vrc_set_default_mapping = 0
let g:vrc_syntax_highlight_response = 1
let g:vrc_response_default_content_type = 'application/json'
let g:vrc_horizontal_split = 1
let g:vrc_auto_format_uhex = 1

" Vim Autoswap
let g:autoswap_detect_tmux = 1

" Vim Obsess
" Loads a session if it exists
if (filereadable("Session.vim"))
    exe 'silent source Session.vim'
endif

" Vim localvimrc
let g:localvimrc_name = ["vimrc"]
let g:localvimrc_ask = 0
let g:localvimrc_file_directory_only = 1

" Grepper
let g:grepper = {}
let g:grepper.highlight = 1


" Vim-Autoformat
let g:formatdef_jsbeautify_javascript = '"js-beautify -X --brace-style=collapse-preserve-inline -".(&expandtab ? "s ".shiftwidth() : "t").(&textwidth ? " -w ".&textwidth : "")'
au BufWrite *.js :Autoformat
let g:formatdef_jsbeautify_json = '"js-beautify --brace-style=collapse-preserve-inline -".(&expandtab ? "s ".shiftwidth() : "t")'
au BufWrite *.json :Autoformat

" LanguageClient
" Requires `npm install -g javascript-typescript-langserver`
" Requires `pip install python-language-server`
let g:LanguageClient_serverCommands = {
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ 'python': ['pyls']
    \ }
let g:LanguageClient_rootMarkers = {
    \ 'python': ['.python-version']
    \ }
let g:LanguageClient_diagnosticsEnable = 1
let g:LanguageClient_autoStart = 1
let g:LanguageClient_changeThrottle = 0.5
let g:necosyntax#min_keyword_length = 1
autocmd VimLeave * !pkill -f "pyls"
autocmd VimLeave * !pkill -f "javascript-typescript-langserver"


" Highlight
let g:indentLine_setColors = 0
hi NonText ctermfg=236 ctermbg=NONE " Gray
hi Normal ctermfg=14 " White
hi Conceal cterm=NONE ctermfg=236 ctermbg=NONE " Gray

"" Syntax
hi Comment cterm=NONE ctermfg=243 ctermbg=NONE " Gray
hi Constant ctermfg=144 " Green
hi Boolean cterm=bold ctermfg=144 " Green
hi Identifier ctermfg=208 " Orange
hi Statement cterm=bold ctermfg=24 " Blue

"" Other Visuals
hi Pmenu ctermfg=blue ctermbg=236 " Gray
hi PmenuThumb ctermbg=243
hi LineNr ctermfg=243 ctermbg=235
hi Folded cterm=bold ctermfg=243 ctermbg=235
hi FoldColumn ctermfg=238 ctermbg=235
hi CursorLineNr cterm=bold ctermfg=White ctermbg=235
hi CursorLine cterm=NONE ctermbg=236 ctermfg=NONE
hi CursorColumn cterm=NONE ctermbg=236 ctermfg=NONE
hi MatchParen cterm=bold,underline ctermbg=NONE ctermfg=NONE
hi Visual ctermbg=238
hi StatusLine cterm=NONE ctermfg=243 ctermbg=236
hi Menu cterm=reverse
hi VertSplit cterm=bold ctermfg=243 ctermbg=NONE
hi Search cterm=NONE ctermfg=Red ctermbg=NONE
hi IncSearch cterm=NONE ctermfg=Black ctermbg=Red
hi WarningMsg cterm=NONE ctermfg=Black ctermbg=Yellow
hi SpellCap cterm=NONE ctermfg=Black ctermbg=Yellow
hi ErrorMsg cterm=NONE ctermfg=White ctermbg=Red
hi SpellBad cterm=NONE ctermfg=White ctermbg=Red
hi Todo cterm=NONE ctermfg=Black ctermbg=Green
hi QuickFixLine cterm=bold ctermfg=NONE ctermbg=NONE
hi SignColumn ctermbg=235
hi DiffAdd cterm=bold ctermfg=232 ctermbg=22 " Green
hi DiffDelete cterm=bold ctermfg=88 ctermbg=NONE " Red
hi DiffChange cterm=bold ctermfg=232 ctermbg=55 " Blue
hi DiffText cterm=bold,underline ctermfg=232 ctermbg=25 " Blue
hi EndOfBuffer ctermfg=Black ctermbg=Black

"" Plugin
hi GitGutterAddDefault ctermfg=2 ctermbg=235
hi GitGutterChangeDefault ctermfg=3 ctermbg=235
hi GitGutterDeleteDefault ctermfg=1 ctermbg=235

" Language Specific


"" Python
augroup python
    autocmd FileType python setlocal keywordprg=":terminal pydoc"
    autocmd FileType python setlocal foldmethod=indent
    autocmd FileType python nnoremap <buffer> <silent> gd :call LanguageClient_textDocument_definition()<CR>
    autocmd FileType python nnoremap <buffer> <silent> K :call LanguageClient_textDocument_hover()<CR>
    autocmd FileType python nnoremap <buffer> <silent> <leader>cr :call LanguageClient_textDocument_rename()<CR>
    autocmd BufWrite *.py :Autoformat
augroup END

"" JavaScript
augroup javascript
    autocmd FileType javascript.jsx nnoremap <buffer> <silent> gd :call LanguageClient_textDocument_definition()<CR>
    autocmd FileType javascript.jsx nnoremap <buffer> <silent> K :call LanguageClient_textDocument_hover()<CR>
    autocmd FileType javascript.jsx nnoremap <buffer> <silent> <leader>cr :call LanguageClient_textDocument_rename()<CR>
augroup END

" vi: et sw=4 sts=4 ts=4
