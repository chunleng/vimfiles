augroup packer_user_config
  autocmd!
  autocmd BufWritePost *.lua source <afile> | PackerCompile
augroup end
