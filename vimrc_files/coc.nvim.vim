" Data structure related
let g:coc_global_extensions = ['coc-json', 'coc-yaml', 'coc-docker']

" Vim related
let g:coc_global_extensions = g:coc_global_extensions + ['coc-ultisnips']

" Non-language related
let g:coc_global_extensions = g:coc_global_extensions + ['coc-markdownlint']

" Language related
let g:coc_global_extensions = g:coc_global_extensions + ['coc-tsserver', 'coc-prettier', 'coc-vetur', 'coc-eslint'] " javascript
let g:coc_global_extensions = g:coc_global_extensions + ['coc-java'] " java
let g:coc_global_extensions = g:coc_global_extensions + ['coc-pyright'] " python
let g:coc_global_extensions = g:coc_global_extensions + ['coc-solargraph'] " ruby
let g:coc_global_extensions = g:coc_global_extensions + ['coc-lua'] " lua

" Others
let g:coc_global_extensions = g:coc_global_extensions + ['coc-tabnine', 'coc-syntax']

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

function! s:GoToDefinition()
  if CocAction('jumpDefinition')
    return v:true
  endif

  let ret = execute("silent! normal \<C-]>")
  if ret =~ "Error" || ret =~ "错误"
    call searchdecl(expand('<cword>'))
  endif
endfunction

" nnoremap <expr> <silent> gd CocHasProvider('definition') ? "\<plug>(coc-definition)" : ":call searchdecl(expand('<cword>'))<cr>"
" nnoremap <expr> <silent> K CocHasProvider('hover') ? ":call CocActionAsync('doHover')<cr>" : ":execute '!' . &keywordprg . ' ' . expand('<cword>')<cr>"

nmap <silent> gd <plug>(coc-definition)
nmap <silent> <leader>cr <plug>(coc-rename)
nmap <silent> <leader>cu <plug>(coc-references)
nmap <silent> <leader>ci <plug>(coc-implementation)
nmap <silent> <leader>cp <plug>(coc-diagnostic-prev)
nmap <silent> <leader>cn <plug>(coc-diagnostic-next)
nmap <silent> <leader>cf <plug>(coc-fix-current)
nmap <silent> = <plug>(coc-format-selected)
vmap <silent> = <plug>(coc-format-selected)
" xmap <silent> = <plug>(coc-format-selected)
nmap <silent> <leader>c= <plug>(coc-format)

hi CocErrorVirtualText gui=italic guifg=#555555
hi CocWarningVirtualText gui=italic guifg=#555555
hi CocInfoVirtualText gui=italic guifg=#555555
hi CocHintVirtualText gui=italic guifg=#555555

 let g:coc_filetype_map = {
 \ 'yaml.docker-compose': 'yaml',
 \ }

nnoremap <silent> !rc :CocConfig<cr>
nnoremap <silent> !rC :CocLocalConfig<cr>
