" Data structure related
let g:coc_global_extensions = ['coc-json', 'coc-yaml', 'coc-docker']

" Vim related
let g:coc_global_extensions = g:coc_global_extensions + ['coc-ultisnips']

" Non-language related
let g:coc_global_extensions = g:coc_global_extensions + ['coc-markdownlint']

" Language related
let g:coc_global_extensions = g:coc_global_extensions + ['coc-tsserver', 'coc-vetur', 'coc-eslint'] " javascript
let g:coc_global_extensions = g:coc_global_extensions + ['coc-java'] " java
let g:coc_global_extensions = g:coc_global_extensions + ['coc-pyright'] " python
let g:coc_global_extensions = g:coc_global_extensions + ['coc-solargraph'] " ruby
let g:coc_global_extensions = g:coc_global_extensions + ['coc-lua'] " lua
let g:coc_global_extensions = g:coc_global_extensions + ['coc-html', 'coc-emmet'] " html

" Others
let g:coc_global_extensions = g:coc_global_extensions + ['coc-tabnine', 'coc-syntax']

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

nnoremap <silent> gd :call <SID>go_to_definition()<CR>
function! s:go_to_definition()
  silent if CocAction('jumpDefinition')
    return v:true
  endif

  let ret = execute("silent! normal \<C-]>")
  if ret =~ "Error" || ret =~ "错误"
    call searchdecl(expand('<cword>'))
  endif
endfunction


nmap <silent> <leader>cc :CocOutline<cr>
nmap <silent> <leader>cr <plug>(coc-rename)
nmap <silent> <leader>cu <plug>(coc-references)
nmap <silent> <leader>ci <plug>(coc-implementation)
nmap <silent> <leader>cp <plug>(coc-diagnostic-prev)
nmap <silent> <leader>cn <plug>(coc-diagnostic-next)
nmap <silent> <leader>cf <plug>(coc-fix-current)
nmap <silent> = <plug>(coc-format-selected)
vmap <silent> = <plug>(coc-format-selected)
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

augroup coc
  autocmd!
  autocmd FileType coctree setlocal nowrap
augroup END
