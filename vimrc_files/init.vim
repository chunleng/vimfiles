" http://google.com
if filereadable('/usr/local/bin/python3')
    let g:python3_host_prog='/usr/local/bin/python3'
endif

if filereadable('/usr/local/bin/neovim-node-host')
    let g:node_host_prog='/usr/local/bin/neovim-node-host'
endif

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
    Plug 'SmiteshP/nvim-gps'

    " Allow to view edit history
    Plug 'simnalamburt/vim-mundo', { 'on': 'MundoToggle' }
    Plug 'lukas-reineke/indent-blankline.nvim'
    Plug 'AndrewRadev/linediff.vim', { 'on': 'Linediff' }

    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'lewis6991/gitsigns.nvim'

    Plug 'SirVer/ultisnips'
    Plug 'embear/vim-localvimrc'

    " Vim test
    Plug 'vim-test/vim-test'

    " Markdown
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'}
    Plug 'amiorin/vim-fenced-code-blocks'

    " Parentheses formatting
    Plug 'cohama/lexima.vim'
    " TODO https://github.com/windwp/nvim-autopairs
    "      able to use with treesitter

    " Show highlight when there is trailing whitespace
    Plug 'bronson/vim-trailing-whitespace'

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
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
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

    " Rails Development
    Plug 'tpope/vim-rails'

    " For language that are not yet covered by treesitter
    Plug 'purescript-contrib/purescript-vim'

    " Following plugin to fix `gx`
    " https://github.com/vim/vim/issues/4738
    "   -> this however doesn't fix `:e https://example.com`
    " Plug 'felipec/vim-sanegx'

    " Additional Syntax Support
    Plug 'aklt/plantuml-syntax'

    " TODO https://github.com/puremourning/vimspector
call plug#end()
" }}}

lua << EOF
require("indent_blankline").setup {
    char = "│",
    filetype_exclude = {'WhichKey','markdown'},
    use_treesitter = true
}
require('gitsigns').setup {
    signs = {
        add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
        change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
        delete       = {hl = 'GitSignsDelete', text = '│', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        topdelete    = {hl = 'GitSignsDelete', text = '│', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        changedelete = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    },
    keymaps = {
        buffer = false,
        ['n <leader>gn'] = '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>',
        ['n <leader>gp'] = '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>',
        ['n <leader>gp'] = '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>',
    },
    current_line_blame = true,
}
require("nvim-gps").setup()
EOF

runtime before-plugin.vim

" Plugin settings ------------------------------------------------------- {{{
runtime nvim-scrollview.vim
runtime vim-visual-multi.vim
runtime nvim-treesitter.vim
runtime nvim-tree.vim
runtime mundo.vim
runtime linediff.vim
runtime vim-fugitive.vim
runtime nvim-bufferline.lua
runtime galaxyline.nvim.lua
runtime ultisnips.vim
runtime coc.nvim.vim
runtime vim-localvimrc.vim
runtime vim-lengthmatters.vim
runtime vim-bufkill.vim
runtime which-key.nvim.vim
runtime fzf.vim
runtime coc-fzf.vim
runtime markdown-preview.vim
runtime vim-fenced-code-blocks.vim
runtime vim-test.vim
runtime vim-rails.vim
runtime vim-sleuth.vim
runtime trailing-whitespace.vim
" }}}

runtime after-plugin.vim

