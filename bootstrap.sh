#!/usr/bin/env bash -eu

APP_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}"  )" && pwd  )"

# install vimrc
mkdir -p $HOME/.config/
ln -sn  ${APP_PATH}/vimrc_files $HOME/.config/nvim

# install dein
DEIN_INSTALL_PATH=${DEIN_INSTALL_PATH:-$HOME/.local/share/dein}
echo $DEIN_INSTALL_PATH

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh -o /tmp/installer.sh
sh /tmp/installer.sh $HOME/.local/share/dein

# install nvim setting
pip install neovim-python
pip3 install neovim-python
nvim -c "call dein#update()" -c "qall" --headless
