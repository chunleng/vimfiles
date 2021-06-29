# When using Neovim

## Manual Configuration

### Lombok

Some coc-settings is needed to make lombok work on Java language server
REF: https://github.com/neoclide/coc-java/issues/27

1. Download lombok (https://projectlombok.org/download or whatever version necessary)
2. Create ".vim/coc-settings.json" and add "Lombok VM settings"
3. Enter vim command `:CocRestart`

```
{
  "java.jdt.ls.vmargs": "-javaagent:path/to/lombok-<version>.jar -Xbootclasspath/a:path/to/lombok-<version>.jar"
}
```

Recommended to add jar to `.vim` folder
