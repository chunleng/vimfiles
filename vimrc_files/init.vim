" For vim related configuration
runtime config.vim

" Plugins --------------------------------------------------------------- {{{
call plug#begin('~/.vim/plugged')
    " Show the menu for leader key
    Plug 'folke/which-key.nvim'

    " File navigator & plugins
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'kyazdani42/nvim-web-devicons'

    " Beautify
    Plug 'glepnir/galaxyline.nvim'
    Plug 'akinsho/nvim-bufferline.lua'

    " Allow to view edit history
    Plug 'simnalamburt/vim-mundo', { 'on': 'MundoToggle' }
    Plug 'Yggdroot/indentLine'
    Plug 'AndrewRadev/linediff.vim', { 'on': 'Linediff' }

    " Git integration
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'

    Plug 'SirVer/ultisnips'
    Plug 'embear/vim-localvimrc'

    " Parentheses formatting
    Plug 'cohama/lexima.vim'
    Plug 'tpope/vim-commentary'
    Plug 'itchyny/vim-cursorword'
    Plug 'whatyouhide/vim-lengthmatters'
    Plug 'tpope/vim-surround'
    Plug 'qpkorr/vim-bufkill'

    " Fuzzy finder for files, grep and more
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    Plug 'neoclide/coc.nvim'
    Plug 'Shougo/neco-vim', { 'for': 'vim' } " Vim autocomplete
    Plug 'neoclide/coc-neco', { 'for': 'vim' } " Vim autocomplete coc.nvim integration
    Plug 'antoinemadec/coc-fzf'

    " Colorscheme
    Plug 'chriskempson/base16-vim'

    " Rails
    Plug 'tpope/vim-rails'

    " Scrollbar
    Plug 'dstein64/nvim-scrollview'

    " Multi cursor
    Plug 'mg979/vim-visual-multi'

    " TreeSitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    " TODO https://github.com/lewis6991/gitsigns.nvim
    " TODO persistent_undo?
call plug#end()
" }}}

runtime rc.vim

" Plugin settings ------------------------------------------------------- {{{
runtime nvim-scrollview.vim
runtime vim-visual-multi.vim
runtime nvim-treesitter.lua
runtime nvim-tree.vim
runtime mundo.vim
runtime indentLine.vim
runtime linediff.vim  
runtime vim-fugitive.vim
runtime nvim-bufferline.lua
runtime galaxyline.nvim.lua
runtime ultisnips.vim
runtime coc.nvim.vim
runtime vim-localvimrc.vim
runtime vim-gitgutter.vim
runtime vim-lengthmatters.vim
runtime vim-bufkill.vim
runtime which-key.nvim.lua
runtime fzf.vim
runtime coc-fzf.vim
" }}}

runtime after-plugin.vim

