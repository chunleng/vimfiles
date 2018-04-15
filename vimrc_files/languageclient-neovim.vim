" Requires `npm install -g javascript-typescript-langserver`
" Requires `pip install python-language-server`
let g:LanguageClient_serverCommands = {
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ 'python': ['pyls']
    \ }
let g:LanguageClient_rootMarkers = {
    \ 'python': ['.python-version','.env']
    \ }
let g:LanguageClient_diagnosticsEnable = 1
let g:LanguageClient_autoStart = 1
let g:LanguageClient_changeThrottle = 0.5

augroup languageclient
    autocmd!
    autocmd VimLeave * silent !pkill -f "pyls"
    autocmd VimLeave * silent !pkill -f "javascript-typescript-langserver"
    autocmd FileType python nnoremap <buffer> <silent> gd :call LanguageClient_textDocument_definition()<CR>
    autocmd FileType python nnoremap <buffer> <silent> K :call LanguageClient_textDocument_hover()<CR>
    autocmd FileType python nnoremap <buffer> <silent> <leader>cr :call LanguageClient_textDocument_rename()<CR>
    autocmd FileType javascript.jsx nnoremap <buffer> <silent> gd :call LanguageClient_textDocument_definition()<CR>
    autocmd FileType javascript.jsx nnoremap <buffer> <silent> K :call LanguageClient_textDocument_hover()<CR>
    autocmd FileType javascript.jsx nnoremap <buffer> <silent> <leader>cr :call LanguageClient_textDocument_rename()<CR>
augroup END
