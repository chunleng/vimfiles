# Usage Guide

## Autoformat on Save

Create to create autoformat on save for each language server, use the following config

```vim
augroup LspFormatting
    autocmd! * <buffer>
    autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting_sync()
augroup END
```

## vim-test setup

`!rV` to get into the localvimrc and use the following to set up the test
environment

```vim
let test#<language>#runner = '<runner>'
let test#<language>#<runner>#executable = 'path/to/executable'

# example
let test#java#runner = 'gradletest'
let test#java#gradletest#executable = 'docker-compose exec web gradle '
```

For reference of the runner's name:

<https://github.com/vim-test/vim-test#features>
