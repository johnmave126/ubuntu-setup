#!/bin/bash
#
# Install tmux, tpm, and configs

echo -e "\e[1m[tmux] \e[0m\e[96minstall tmux\e[0m"
sudo apt-get install -y tmux

# Set up tmux
mkdir -p ~/.tmux
echo -e "\e[1m[tmux] \e[0m\e[96mSet up tmux config\e[0m"
cp .tmux.conf ~/.tmux.conf

