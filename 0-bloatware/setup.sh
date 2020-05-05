#!/bin/bash
#
# Remove bloatware coming with Ubuntu-Desktop

echo -e "\e[1m[bloatware] \e[0m\e[96mremove bloatware\e[0m"
sudo apt-get remove -y update-notifier thunderbird rhythmbox

# Hide amazon
echo -e "\e[1m[bloatware] \e[0m\e[96mremove Amazon shortcut\e[0m"
echo 'Hidden=true' | cat /usr/share/applications/ubuntu-amazon-default.desktop - > ~/.local/share/applications/ubuntu-amazon-default.desktop
echo -e "\e[1m[bloatware] \e[0m\e[96mdone\e[0m"
