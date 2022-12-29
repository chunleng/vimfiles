vim.cmd [[
augroup LspFormatting
    autocmd! * <buffer>
    autocmd BufWritePre <buffer> lua vim.lsp.buf.format({timeout_ms=5000})
augroup END

augroup packer_user_config
  autocmd!
  autocmd BufWritePost *.lua source <afile> | PackerCompile
augroup end
]]
