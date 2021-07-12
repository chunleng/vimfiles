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

    " Vim test
    Plug 'vim-test/vim-test'

    " Markdown
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'}

    " Parentheses formatting
    Plug 'cohama/lexima.vim'
    " TODO https://github.com/windwp/nvim-autopairs
    "      able to use with treesitter

    " For Commenting
    Plug 'tpope/vim-commentary'

    " Underline all other instance of word under cursor
    Plug 'itchyny/vim-cursorword'
    Plug 'whatyouhide/vim-lengthmatters'
    Plug 'tpope/vim-surround'
    Plug 'qpkorr/vim-bufkill'

    " Fuzzy finder for files, grep and more
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    " Code Intellisense
    Plug 'neoclide/coc.nvim'
    Plug 'Shougo/neco-vim', { 'for': 'vim' } " Vim autocomplete
    Plug 'neoclide/coc-neco', { 'for': 'vim' } " Vim autocomplete coc.nvim integration
    Plug 'antoinemadec/coc-fzf'

    " Colorscheme
    Plug 'chriskempson/base16-vim'

    " Scrollbar
    Plug 'dstein64/nvim-scrollview'

    " Multi cursor edit
    Plug 'mg979/vim-visual-multi'

    " TreeSitter: Better highlight and autoindent information
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    " Allow autodetect of file indent
    Plug 'tpope/vim-sleuth'

    " TODO https://github.com/lewis6991/gitsigns.nvim
call plug#end()
" }}}

runtime before-plugin.vim

" Plugin settings ------------------------------------------------------- {{{
runtime nvim-scrollview.vim
runtime vim-visual-multi.vim
runtime nvim-treesitter.vim
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
runtime which-key.nvim.vim
runtime fzf.vim
runtime coc-fzf.vim
runtime markdown-preview.vim
runtime vim-test.vim
" }}}

runtime after-plugin.vim

