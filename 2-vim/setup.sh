#!/bin/bash
#
# Install vim, monokai theme, and common plugins

echo -e "\e[1m[vim] \e[0m\e[96minstall vim\e[0m"
tput smcup
sudo apt install -y vim
tput rmcup

# Install Vundle
echo -e "\e[1m[vim] \e[0m\e[96minstall Vundle\e[0m"
tput smcup
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
tput rmcup

# Copy vimrc
echo -e "\e[1m[vim] \e[0m\e[96minstall plugins\e[0m"
tput smcup
cp -f .vimrc ~/.vimrc
# Install all plugins
vim +PluginInstall +qall
tput rmcup

# Setup YCM
echo -e "\e[1m[vim] \e[0m\e[96msetup YCM\e[0m"
tput smcup
pushd ~/.vim/bundle/YouCompleteMe
python3 install.py --all
popd
tput rmcup
