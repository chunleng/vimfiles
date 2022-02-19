# Usage Guide

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
