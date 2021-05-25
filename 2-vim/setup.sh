#!/bin/bash
#
# Install vim, monokai theme, and common plugins

echo -e "\e[1m[vim] \e[0m\e[96minstall vim and Anonymous Pro\e[0m"
sudo apt-get install -y vim-nox libncurses5-dev libz3-dev xz-utils \
                        libpthread-workqueue-dev \
                        pkg-config autoconf automake checkinstall \
                        python3-docutils libseccomp-dev libjansson-dev \
                        libyaml-dev libxml2-dev fontconfig
RUBY_VER=$(vim --version | grep -Po '(?<=ruby-)\d+\.\d+')
LUA=$(vim --version | grep -Po 'lua\d+\.\d+')
sudo apt-get install -y lib$LUA-dev $LUA ruby$RUBY_VER-dev
wget -P /tmp https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/AnonymousPro.zip
sudo unzip -d /usr/share/fonts/truetype/anonymous-pro /tmp/AnonymousPro.zip
fc-cache -f -v

# Install Vundle
echo -e "\e[1m[vim] \e[0m\e[96minstall Vundle\e[0m"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install ctags
echo -e "\e[1m[vim] \e[0m\e[96minstall ctags\e[0m"
pushd /tmp >/dev/null
git clone https://github.com/universal-ctags/ctags.git
cd ctags
./autogen.sh
./configure
make
echo >description-pak <<EOF
A maintained ctags implementation
EOF
sudo checkinstall -y --pkgversion="0.0.0~$(date +%Y%m%d)-git" --maintainer="universal-ctags@ctags.io"
popd >/dev/null

# Copy vimrc
echo -e "\e[1m[vim] \e[0m\e[96minstall plugins\e[0m"
sed -e '/colo monokai/d' .vimrc >~/.vimrc
# Install all plugins
vim +PluginInstall +qall
cp -f .vimrc ~/.vimrc

# Copy yank script
cp -f yank.sh ~/yank.sh

# Setup YCM
echo -e "\e[1m[vim] \e[0m\e[96msetup YCM\e[0m"
pushd ~/.vim/bundle/YouCompleteMe >/dev/null
python3 install.py --clangd-completer --cs-completer --go-completer --ts-completer --rust-completer
popd >/dev/null

# Setup color_coded
echo -e "\e[1m[vim] \e[0m\e[96msetup color_coded\e[0m"
pushd ~/.vim/bundle/color_coded >/dev/null
mkdir -p build && cd build
cmake ..
make && make install
make clean && make clean_clang
popd >/dev/null

# Setup color_coded
echo -e "\e[1m[vim] \e[0m\e[96msetup command-t\e[0m"
pushd ~/.vim/bundle/command-t/ruby/command-t/ext/command-t >/dev/null
ruby extconf.rb
make
popd >/dev/null

cat >>~/.bashrc <<"EOF"
export VISUAL=vim
export EDITOR="$VISUAL"
EOF

git config --global core.editor "vim"

