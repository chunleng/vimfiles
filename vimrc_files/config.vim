" set to use global python (even when virtualenv-ed)
let g:python_host_prog=$HOME.'/.pyenv/shims/python2'
let g:python3_host_prog=$HOME.'/.pyenv/shims/python3'

" mandatory configuration
let g:dein_install_path=$HOME.'/.local/share/dein/repos/github.com/Shougo/dein.vim'

" optional configuration (should work with default value)
let g:dein_plugin_path=$HOME.'/.local/share/dein_plugin'

" plugin related configuration
"" Ultisnip
let g:UltiSnipsSnippetsDir=$HOME."/.local/share/dein.plugin/repos/bitbucket.org/chunleng/ultisnips-snippet/Ultisnips"
