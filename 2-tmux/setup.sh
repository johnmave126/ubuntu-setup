#!/bin/bash
#
# Install tmux, tpm, and configs

echo -e "\e[1m[tmux] \e[0m\e[96minstall tmux\e[0m"
sudo apt-get install -y tmux

# Set up tmux
mkdir -p ~/.tmux
echo -e "\e[1m[tmux] \e[0m\e[96mSet up tmux config\e[0m"
cp .tmux.conf ~/.tmux.conf
wget -O ~/.tmux/tmux-complete https://raw.githubusercontent.com/imomaliev/tmux-bash-completion/master/completions/tmux
echo ". ~/.tmux/tmux-complete" >>~/.bashrc

# Set up plugins
echo -e "\e[1m[tmux] \e[0m\e[96mSet up tmux plugins\e[0m"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
export TMUX_PLUGIN_MANAGER_PATH=$HOME/.tmux/plugins/tpm
~/.tmux/plugins/tpm/bin/install_plugins

