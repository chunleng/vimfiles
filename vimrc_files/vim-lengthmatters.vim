nnoremap <leader>to :LengthmattersToggle<cr>

autocmd BufReadPre *.min.* set ft=min
" markdown: leave it for markdownlint
let g:lengthmatters_excluded = ['Mundo', 'MundoDiff', 'NvimTree', 'help', 'qf', 'WhichKey', 'min', 'markdown']

call lengthmatters#highlight('gui=undercurl')

" Type specific length
autocmd BufReadPre *.md setlocal textwidth=80

