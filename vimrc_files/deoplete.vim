let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#enable_refresh_always = 1

call deoplete#custom#source('_', 'matchers', ['matcher_fuzzy'])
call deoplete#custom#source('ultisnips', 'matchers', ['matcher_full_fuzzy'])
