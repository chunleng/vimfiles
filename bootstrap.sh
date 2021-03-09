#!/usr/bin/env bash

set eu

APP_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}"  )" && pwd  )"

# install vimrc
mkdir -p $HOME/.config/
ln -sn  ${APP_PATH}/vimrc_files $HOME/.config/nvim

# install dein
DEIN_INSTALL_PATH=${DEIN_INSTALL_PATH:-$HOME/.local/share/dein}
echo $DEIN_INSTALL_PATH

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh -o /tmp/installer.sh
sh /tmp/installer.sh $HOME/.local/share/dein

# python-language-server settings
mkdir $HOME/.vim
ln -sn ${APP_PATH}/pyls.json $HOME/.vim/settings.json

nvim -c "call dein#update()" -c "qall" --headless

# deoplete
nvim -c "UpdateRemotePlugins" -c "qall" --headless
