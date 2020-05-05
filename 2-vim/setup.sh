#!/bin/bash
#
# Install vim, monokai theme, and common plugins

echo -e "\e[1m[vim] \e[0m\e[96minstall vim and Anonymous Pro\e[0m"
sudo apt-get install -y vim.nox libncurses5-dev libz3-dev xz-utils libpthread-workqueue-dev liblua5.2-dev lua5.2
wget -P /tmp https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/AnonymousPro.zip
sudo unzip -d /usr/share/fonts/truetype/anonymous-pro /tmp/AnonymousPro.zip
fc-cache -f -v

# Install Vundle
echo -e "\e[1m[vim] \e[0m\e[96minstall Vundle\e[0m"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Copy vimrc
echo -e "\e[1m[vim] \e[0m\e[96minstall plugins\e[0m"
sed -e '/colo monokai/d' .vimrc >~/.vimrc
# Install all plugins
vim +PluginInstall +qall
cp -f .vimrc ~/.vimrc

# Setup YCM
echo -e "\e[1m[vim] \e[0m\e[96msetup YCM\e[0m"
pushd ~/.vim/bundle/YouCompleteMe >/dev/null
python3 install.py --all
popd >/dev/null

# Setup color_coded
echo -e "\e[1m[vim] \e[0m\e[96msetup color_coded\e[0m"
pushd ~/.vim/bundle/color_coded >/dev/null
mkdir build && cd build
cmake ..
make && make install
make clean && make clean_clang
popd >/dev/null

cat >>~/.bashrc <EOF
export VISUAL=vim
export EDITOR="$VISUAL"
EOF

git config --global core.editor "vim"

