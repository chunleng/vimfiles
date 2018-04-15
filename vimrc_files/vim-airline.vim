let g:airline_extensions = ['branch', 'tabline']
let g:airline_exclude_filetypes = ['nerdtree','qf']
let g:airline_section_c = airline#section#create(['%<', 'readonly'])
let g:airline_section_z = airline#section#create(['linenr', 'maxlinenr', ':%v'])
let g:airline_powerline_fonts=0
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#buffer_nr_show=1
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.notexists = ' '
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.modified = '⁺'
let g:airline_mode_map = {
            \ '__' : '-',
            \ 'n'  : 'N',
            \ 'i'  : 'I',
            \ 'R'  : 'R',
            \ 'v'  : 'V',
            \ 'V'  : 'V _',
            \ 'c'  : 'C',
            \ '' : 'V ',
            \ 's'  : 'S',
            \ 'S'  : 'S _',
            \ '' : 'S ',
            \ 't'  : ''
            \ }
