#!/usr/bin/env bash

set eu

APP_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}"  )" && pwd  )"

# install vimrc
mkdir -p $HOME/.config/nvim
ln -sn ${APP_PATH}/vimrc_files/init.lua $HOME/.config/nvim/
ln -sn ${APP_PATH}/vimrc_files/lua $HOME/.config/nvim/lua
ln -sn ${APP_PATH}/vimrc_files/UltiSnips $HOME/.config/nvim/UltiSnips
ln -sn ${APP_PATH}/vimrc_files/snippets $HOME/.config/nvim/snippets

test -d ~/.local/share/nvim/lazy/lazy.nvim || \
    git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable \
    ~/.local/share/nvim/lazy/lazy.nvim
