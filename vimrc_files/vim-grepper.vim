nnoremap <leader>sa :Grepper<cr>
nnoremap <leader>su :Grepper -cword -noprompt<cr><cr>

let g:grepper = {}
let g:grepper.tools = ['ag', 'grep']
let g:grepper.highlight = 1
