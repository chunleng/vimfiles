#!/usr/bin/env bash

set eu

APP_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}"  )" && pwd  )"

# install vimrc
mkdir -p $HOME/.config/
ln -sn ${APP_PATH}/vimrc_files $HOME/.config/nvim
cp ${APP_PATH}/tabnine.json $HOME/Library/Preferences/TabNine/tabnine_config.json

test -f ~/.vim/autoload/plug.vim || \
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

nvim -c "PlugInstall|qall" --headless
