noremap <silent><leader>ce :<c-u>call quickrun#run(g:quickrun_config)<cr>

let g:quickrun_no_default_key_mappings=1

let g:quickrun_config = {
            \ 'outputter/buffer/split': '',
            \ 'outputter/buffer/running_mark': 'Loading Execution...'
            \ }
let g:quickrun_config.html = {
            \ 'runner': 'vimscript',
            \ 'command': ':OpenBrowser',
            \ 'exec': '%c %S',
            \ 'outputter': 'null'
            \ }
let g:quickrun_config.markdown = {
            \ 'type': 'markdown/pandoc',
            \ 'cmdopt': '--toc -s',
            \ 'outputter': 'browser'
            \ }
