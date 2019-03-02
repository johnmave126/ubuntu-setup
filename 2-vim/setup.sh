#!/bin/bash
#
# Install vim, monokai theme, and common plugins

sudo apt install -y vim

# Install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Copy vimrc
cp -f .vimrc ~/.vimrc
# Install all plugins
vim +PluginInstall +qall

# Setup YCM
pushd ~/.vim/bundle/YouCompleteMe
python3 install.py --all
popd
