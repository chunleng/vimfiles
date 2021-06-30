augroup coc
    autocmd!
    autocmd FileType java,python,ruby,javascript,typescript,typescriptreact,purescript,vue nmap <buffer> <silent> gd <plug>(coc-definition)
    autocmd FileType java,python,ruby,javascript,typescript,typescriptreact nmap <buffer> <silent> <leader>cr <plug>(coc-rename)
    autocmd FileType java,python,ruby,javascript,typescript,typescriptreact,purescript,vue nmap <buffer> <silent> <leader>cu <plug>(coc-references)
    autocmd FileType java,python,ruby,javascript,typescript,typescriptreact,purescript,vue nmap <buffer> <silent> <leader>ci <plug>(coc-implementation)
    autocmd FileType java,python,ruby,javascript,typescript,typescriptreact,purescript,vue nmap <buffer> <silent> <leader>cp <plug>(coc-diagnostic-prev)
    autocmd FileType java,python,ruby,javascript,typescript,typescriptreact,purescript,vue nmap <buffer> <silent> <leader>cn <plug>(coc-diagnostic-next)
    autocmd FileType java,ruby,javascript,typescript,typescriptreact,purescript,vue nmap <buffer> <silent> <leader>cf <plug>(coc-fix-current)
    autocmd FileType java,javascript,typescript,typescriptreact nmap <buffer> <silent> = <plug>(coc-format-selected)
    autocmd FileType java,javascript,typescript,typescriptreact xmap <buffer> <silent> = <plug>(coc-format-selected)
    autocmd FileType java,python,javascript,typescript,typescriptreact,purescript,vue nmap <buffer> <silent> <leader>c= <plug>(coc-format)
augroup END

hi CocErrorVirtualText gui=italic guifg=#555555
hi CocWarningVirtualText gui=italic guifg=#555555
hi CocInfoVirtualText gui=italic guifg=#555555
hi CocHintVirtualText gui=italic guifg=#555555

 let g:coc_filetype_map = {
 \ 'yaml.docker-compose': 'yaml',
 \ }
