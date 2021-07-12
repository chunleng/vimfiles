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

# coc.nvim

# Data structure
COC_PACKAGES="coc-json coc-yaml coc-docker"

# Vim-related
COC_PACKAGES="${COC_PACKAGES} coc-ultisnips"

# Language-related
COC_PACKAGES="${COC_PACKAGES} coc-html coc-htmlhint coc-css coc-emmet"
COC_PACKAGES="${COC_PACKAGES} coc-tsserver coc-prettier coc-vetur coc-eslint" # typescript/javascript/react/vue
COC_PACKAGES="${COC_PACKAGES} coc-java" # java
COC_PACKAGES="${COC_PACKAGES} coc-pyright" # python
COC_PACKAGES="${COC_PACKAGES} coc-solargraph" # ruby
COC_PACKAGES="${COC_PACKAGES} coc-lua" # lua

# Others
COC_PACKAGES="${COC_PACKAGES} coc-tabnine coc-syntax"

nvim -c "CocInstall -sync ${COC_PACKAGES} | qall" --headless

# TreeSitter
nvim -c "TSUpdate maintained" -c "qall" --headless
