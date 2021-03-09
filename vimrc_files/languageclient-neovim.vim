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

"""""""""""""
"  Display  "
"""""""""""""

let g:LanguageClient_floatingHoverHighlight = "Pmenu:Pmenu"
let g:LanguageClient_virtualTextPrefix = "         "
let g:LanguageClient_diagnosticsDisplay = {
    \ 1: {
    \     "name": "Error",
    \     "texthl": "LanguageClientText",
    \     "signText": "",
    \     "signTexthl": "LanguageClientErrorSign",
    \     "virtualTexthl": "LanguageClientVirtual"
    \ },
    \ 2: {
    \     "name": "Warning",
    \     "texthl": "LanguageClientText",
    \     "signText": "",
    \     "signTexthl": "LanguageClientWarningSign",
    \     "virtualTexthl": "LanguageClientVirtual"
    \ },
    \ 3: {
    \     "name": "Information",
    \     "texthl": "LanguageClientText",
    \     "signText": "",
    \     "signTexthl": "LanguageClientInfoSign",
    \     "virtualTexthl": "LanguageClientVirtual"
    \ },
    \ 4: {
    \     "name": "Hint",
    \     "texthl": "LanguageClientText",
    \     "signText": "ﯦ",
    \     "signTexthl": "LanguageClientHintSign",
    \     "virtualTexthl": "LanguageClientVirtual"
    \ }
    \ }

hi LanguageClientText cterm=underline
hi LanguageClientVirtual cterm=italic ctermfg=240
hi LanguageClientErrorSign ctermfg=red
hi LanguageClientWarningSign ctermfg=yellow
hi LanguageClientInfoSign ctermfg=blue
hi LanguageClientHintSign ctermfg=yellow
