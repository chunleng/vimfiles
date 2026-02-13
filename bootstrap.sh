#!/usr/bin/env bash

set eu

APP_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}"  )" && pwd  )"
LAZY_INSTALL_DIR="${HOME}/.local/share/nvim/lazy/lazy.nvim"

# install vimrc
mkdir -p $HOME/.config/nvim
ln -sfn ${APP_PATH}/vimrc_files/init.lua $HOME/.config/nvim/
ln -sfn ${APP_PATH}/vimrc_files/lua $HOME/.config/nvim/lua
ln -sfn ${APP_PATH}/lazy-lock.json $HOME/.config/nvim/
ln -sfn ${APP_PATH}/vimrc_files/snippets $HOME/.config/nvim/snippets
ln -sfn ${APP_PATH}/mason-lock.json $HOME/.config/nvim/
ln -sfn ${APP_PATH}/mcp.json $HOME/.mcp.json

test -d ${LAZY_INSTALL_DIR} || \
    git clone --filter=blob:none https://github.com/folke/lazy.nvim.git ${LAZY_INSTALL_DIR}
