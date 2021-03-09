nnoremap <leader>to :LengthmattersToggle<cr>
autocmd BufReadPre *.min.* set ft=min
let g:lengthmatters_excluded = ['unite', 'tagbar', 'startify', 'gundo', 'vimshell', 'w3m', 'nerdtree', 'help', 'qf', 'dirvish', 'leaderGuide', 'min']
let g:lengthmatters_highlight_one_column = 1
call lengthmatters#highlight('ctermbg=Yellow')


" Allow lengthmatters to handle textwidth related function
set textwidth=120

autocmd BufReadPre *.md setlocal textwidth=80

