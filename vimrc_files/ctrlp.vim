nnoremap <silent><leader>sf :CtrlP<cr>

let g:ctrlp_map = ''
let g:ctrlp_cmd = ''
let g:ctrlp_working_path_mode = 'w'
let g:ctrlp_prompt_mappings = {
            \ 'PrtSelectMove("j")':   ['<c-n>'],
            \ 'PrtSelectMove("k")':   ['<c-p>'],
            \ 'PrtHistory(-1)':       ['<down>'],
            \ 'PrtHistory(1)':        ['<up>']
            \}
