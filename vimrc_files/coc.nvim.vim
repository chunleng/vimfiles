augroup coc
    autocmd!
    autocmd FileType java,python,ruby,typescript,typescriptreact nmap <buffer> <silent> gd <plug>(coc-definition)
    autocmd FileType java,python,ruby,typescript,typescriptreact nmap <buffer> <silent> K <plug>(coc-definition)
    autocmd FileType java,python,ruby,typescript,typescriptreact nmap <buffer> <silent> <leader>cr <plug>(coc-rename)
    autocmd FileType java,python,ruby,typescript,typescriptreact nmap <buffer> <silent> <leader>cf <plug>(coc-references)
    autocmd FileType java,python,ruby,typescript,typescriptreact nmap <buffer> <silent> <leader>cn <plug>(coc-diagnostic-previous)
    autocmd FileType java,python,ruby,typescript,typescriptreact nmap <buffer> <silent> <leader>cn <plug>(coc-diagnostic-next)
    autocmd FileType java,python,typescript,typescriptreact nmap <buffer> <silent> = <plug>(coc-format)
    autocmd FileType java,python,typescript,typescriptreact vmap <buffer> <silent> = <plug>(coc-format-selected)
augroup END

hi CocErrorSign ctermfg=red
hi CocWarningSign ctermfg=yellow
hi CocInfoSign ctermfg=blue
hi CocHintSign ctermfg=yellow
hi CocFloating ctermbg=240 ctermfg=234

hi CocErrorVirtualText cterm=italic ctermfg=240
hi CocWarningVirtualText cterm=italic ctermfg=240
hi CocInfoVirtualText cterm=italic ctermfg=240
hi CocHintVirtualText cterm=italic ctermfg=240

 let g:coc_filetype_map = {
 \ 'yaml.docker-compose': 'yaml',
 \ }
