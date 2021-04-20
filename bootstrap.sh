#!/usr/bin/env bash

set eu

APP_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}"  )" && pwd  )"

# install vimrc
mkdir -p $HOME/.config/
ln -sn  ${APP_PATH}/vimrc_files $HOME/.config/nvim

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

nvim -c "PlugInstall|qall" --headless

# coc.nvim
nvim -c "CocInstall -sync coc-json coc-yaml coc-ultisnips coc-html coc-htmlhint coc-css coc-tabnine coc-neco coc-tsserver coc-java coc-jedi coc-solargraph|qall" --headless
  # coc-neco: viml
  # coc-jedi: python
  # coc-solargraph: ruby
