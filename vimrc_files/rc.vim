" Default Vim
filetype plugin indent on
syntax enable
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
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevelstart=99
set formatoptions-=r
set formatoptions-=o
set complete=.,w
set completeopt-=preview
set sessionoptions+=resize,winpos
set list
set listchars=tab:»\ ,trail:·,extends:,precedes:,nbsp:+,eol:¶
set fillchars=vert:│,stlnc:\ ,diff:·,eob:\ ,
set incsearch
set hlsearch
set laststatus=2
set wildmenu
set wildmode=list:longest,full
set showcmd
set timeout ttimeout timeoutlen=300 ttimeoutlen=-1
set fileencodings=ucs-bom,utf-8,sjis,default
set synmaxcol=160
set nowrap
scriptencoding utf-8

let g:mapleader="\<space>"

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
