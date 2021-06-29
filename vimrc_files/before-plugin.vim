" Turn on syntax (in case treesitter is not working)
filetype plugin indent on
syntax enable

" Side bar numbering
set number
set relativenumber

" Indent Information
set shiftwidth=4
set softtabstop=4
set tabstop=4
set autoindent
set expandtab
set smarttab


" Make more consistent splitting for easier key setting later
set splitbelow
set splitright

set complete=.,w
set completeopt-=preview
set list
set listchars=tab:»\ ,trail:·,extends:,precedes:,nbsp:+,eol:¶
set fillchars=vert:│,stlnc:\ ,diff:·,eob:\ ,

" '/' Search related
set incsearch
set hlsearch

" Show statusline always
set laststatus=2

" Show to characters typed on the bottom right
set showcmd

set timeout ttimeout timeoutlen=300 ttimeoutlen=-1
set fileencodings=ucs-bom,utf-8,sjis,default
set synmaxcol=160
set textwidth=120
set sidescrolloff=20
set nowrap
scriptencoding utf-8

" Other preferred settings
set nocompatible
set hidden
set lazyredraw

let g:mapleader="\<space>"

" Highlight Formatting -------------------------------------------------- {{{
set termguicolors
let base16colorspace=256
colorscheme base16-tomorrow-night
hi NonText guifg=#333333 guibg=None

"" Syntax
hi Comment gui=italic guifg=#777777 guibg=None

"" Other Visuals
hi MatchParen gui=bold,italic guibg=NONE guifg=NONE
hi StatusLine gui=NONE guifg=#333333 guibg=NONE
hi StatusLineNC gui=NONE guifg=#333333 guibg=NONE
hi VertSplit gui=NONE guifg=#333333 guibg=NONE
hi DiffAdd guifg=black guibg=s:gui0B
hi DiffDelete guifg=black guibg=red
hi DiffChange gui=bold guifg=NONE guibg=NONE
hi DiffText gui=bold guifg=black guibg=blue

"" Gutter
hi LineNr guibg=NONE
hi CursorLineNr guibg=NONE
hi SignColumn guibg=NONE
hi FoldColumn guibg=NONE
" }}}
