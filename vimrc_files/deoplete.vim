let g:deoplete#enable_at_startup = 1

call deoplete#custom#option({
    \ 'auto_complete_delay': 100,
    \ 'camel_case': 1
    \ })

call deoplete#custom#source('_', 'matchers', ['matcher_fuzzy'])
call deoplete#custom#source('ultisnips', 'matchers', ['matcher_full_fuzzy'])
