# Usage Guide

## coc-java Manual Configuration

### Lombok

Some coc-settings is needed to make lombok work on Java language server
REF: https://github.com/neoclide/coc-java/issues/27

1. Download lombok (https://projectlombok.org/download or whatever version necessary)
2. Create ".vim/coc-settings.json" by pressing `!rC` and add "Lombok VM settings"
3. Enter vim command `:CocRestart`

```
{
  "java.jdt.ls.vmargs": "-javaagent:path/to/lombok-<version>.jar -Xbootclasspath/a:path/to/lombok-<version>.jar"
}
```

Recommended to add jar to `.vim` folder

### Autosave

Create to create autosave for each language server, use the following config

```
{
  "eslint.autoFixOnSave": true // javascript","javascriptreact","typescript","typescriptreact","html","vue","markdown""
}
```


## vim-test setup

`!rV` to get into the localvimrc and use the following to set up the test
environment

```
let test#<language>#runner = '<runner>'
let test#<language>#<runner>#executable = 'path/to/executable'

# example
let test#java#runner = 'gradletest'
let test#java#gradletest#executable = 'docker-compose exec web gradle '
```

For reference of the runner's name:

https://github.com/vim-test/vim-test#features
