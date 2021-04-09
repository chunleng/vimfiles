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

nvim -c "call dein#update()|qall" --headless

# coc.nvim
nvim -c "CocInstall -sync coc-json coc-yaml coc-ultisnips coc-html coc-css coc-tabnine coc-neco coc-tsserver coc-java coc-jedi|qall" --headless
