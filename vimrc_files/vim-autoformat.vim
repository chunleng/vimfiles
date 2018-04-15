let g:formatdef_jsbeautify_javascript = '"js-beautify -X --brace-style=collapse-preserve-inline -".(&expandtab ? "s ".shiftwidth() : "t").(&textwidth ? " -w ".&textwidth : "")'
let g:formatdef_jsbeautify_json = '"js-beautify --brace-style=collapse-preserve-inline -".(&expandtab ? "s ".shiftwidth() : "t")'

augroup autoformat
    autocmd!
    autocmd BufWrite *.js :Autoformat
    autocmd BufWrite *.json :Autoformat
    autocmd BufWrite *.py :Autoformat
augroup END
