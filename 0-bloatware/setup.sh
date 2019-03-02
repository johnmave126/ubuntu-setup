#!/bin/bash
#
# Remove bloatware coming with Ubuntu-Desktop

echo -e "\e[1m[bloatware] \e[21;96mremove bloatware\e[0m"
tput smcup
sudo apt remove -y update-notifier thunderbird rhythmbox
tput rmcup

# Hide amazon
echo -e "\e[1m[bloatware] \e[21;96mremove Amazon shortcut\e[0m"
echo 'Hidden=true' | cat /usr/share/applications/ubuntu-amazon-default.desktop - > ~/.local/share/applications/ubuntu-amazon-default.desktop
echo -e "\e[1m[bloatware] \e[21;96mdone\e[0m"