#!/usr/bin/env bash

set eu

APP_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}"  )" && pwd  )"

# install vimrc
mkdir -p $HOME/.config/nvim
ln -sn ${APP_PATH}/vimrc_files/init.lua $HOME/.config/nvim/
ln -sn ${APP_PATH}/vimrc_files/src $HOME/.config/nvim/src
ln -sn ${APP_PATH}/vimrc_files/lua $HOME/.config/nvim/lua
ln -sn ${APP_PATH}/vimrc_files/UltiSnips $HOME/.config/nvim/UltiSnips
ln -sn ${APP_PATH}/scripts $HOME/.local/share/nvim-scripts

test -d ~/.local/share/nvim/site/pack/packer/start/packer.nvim || \
    git clone --depth 1 https://github.com/wbthomason/packer.nvim \
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim

nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
