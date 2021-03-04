" Requires `pip install python-language-server`
let g:LanguageClient_serverCommands = {
    \ 'python': ['pyls'],
    \ 'java': ['lang_server_mac.sh']
    \ }
let g:LanguageClient_rootMarkers = {
    \ 'python': ['.pyenv'],
    \ 'java': ['.java-version']
    \}
let g:LanguageClient_diagnosticsEnable = 1
let g:LanguageClient_autoStart = 1
let g:LanguageClient_autoStop = 1
let g:LanguageClient_changeThrottle = 1

augroup languageclient
    autocmd!
    autocmd FileType python nnoremap <buffer> <silent> gd :call LanguageClient_textDocument_definition()<CR>
    autocmd FileType python nnoremap <buffer> <silent> K :call LanguageClient_textDocument_hover()<CR>
    autocmd FileType python nnoremap <buffer> <silent> <leader>cr :call LanguageClient_textDocument_rename()<CR>
    autocmd FileType java nnoremap <buffer> <silent> gd :call LanguageClient_textDocument_definition()<CR>
    autocmd FileType java nnoremap <buffer> <silent> K :call LanguageClient_textDocument_hover()<CR>
    autocmd FileType java nnoremap <buffer> <silent> <leader>cr :call LanguageClient_textDocument_rename()<CR>
augroup END
