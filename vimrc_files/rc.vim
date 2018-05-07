set shell=/bin/bash

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
set listchars=tab:»\ ,trail:·,extends:,precedes:,nbsp:+,eol:¶
set fillchars=vert:\ ,stlnc:\ ,diff:·
set incsearch
set hlsearch
set laststatus=2
set wildmenu
set wildmode=list:longest,full
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

set bg=dark
colorscheme default


" Allow more % start-end matching
runtime macros/matchit.vim

let g:mapleader="\<space>"
