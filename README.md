# Usage Guide

## coc-java Manual Configuration

### Lombok

Some coc-settings is needed to make lombok work on Java language server
REF: <https://github.com/neoclide/coc-java/issues/27>

1. Download lombok (<https://projectlombok.org/download> or whatever version necessary)
2. Create ".vim/coc-settings.json" by pressing `!rC` and add "Lombok VM settings"
3. Enter vim command `:CocRestart`

```json
{
  "java.jdt.ls.vmargs": "-javaagent:path/to/lombok-<version>.jar"
}
```

Recommended to add jar to `.vim` folder

### Autosave

Create to create autosave for each language server, use the following config

```json
{
  "eslint.autoFixOnSave": true // javascript","javascriptreact","typescript","typescriptreact","html","vue","markdown""
}
```

### Ruby setup

Solargraph is needed for the autocompletion to work properly

Use `bundle exec` if necessary

```shell
# For all project
gem install solargraph
solargraph download-core
yard gems
yard config --gem-install-yri

# Rails only
solargraph bundle
# add a new file config/definitions.rb and add the contents of the following file:
# https://gist.github.com/castwide/28b349566a223dfb439a337aea29713e
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
