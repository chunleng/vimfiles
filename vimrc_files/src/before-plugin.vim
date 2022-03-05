" Turn on syntax (in case treesitter is not working)
filetype plugin indent on
syntax enable

" Side bar numbering
set number
set relativenumber

" Indent Information
set shiftwidth=2
set softtabstop=2
set tabstop=2
set autoindent
set expandtab
set smarttab
set noswapfile


" Make more consistent splitting for easier key setting later
set splitbelow
set splitright

set complete=.,w
set completeopt-=preview
set list
set listchars=tab:»\ ,trail:·,extends:,precedes:,nbsp:+,eol:¶
set fillchars=vert:│,stlnc:\ ,diff:·,eob:\ ,fold:\ ,foldopen:,foldclose:,foldsep:│

" '/' Search related
set incsearch
set hlsearch
set smartcase

" Show statusline always
set laststatus=2

" Show characters typed on the bottom right
set showcmd

" CursorHold event trigger frequency, currently needed for updating b:coc_current_function
set updatetime=300

set timeout ttimeout timeoutlen=2000 ttimeoutlen=100
set fileencodings=ucs-bom,utf-8,sjis,default
set synmaxcol=160
set textwidth=120
autocmd BufReadPre *.md setlocal textwidth=80
autocmd BufReadPre *.min.* set ft=min " Allow no highlighting for min files
" direnv settings
autocmd BufRead,BufNewFile .env* :set ft=sh
autocmd FileType zsh :set ft=bash " Because treesitter don't support zsh
set sidescrolloff=20
set scrolloff=5
set nowrap
scriptencoding utf-8

" Other preferred settings
set nocompatible
set hidden
set lazyredraw

let g:mapleader="\<space>"

augroup plist
    autocmd!
    autocmd BufRead,BufNewFile *.plist setlocal ft=xml
augroup END
