#!/bin/bash
#
# Remove bloatware coming with Ubuntu-Desktop

sudo apt remove -y update-notifier thunderbird rhythmbox

# Hide amazon
echo 'Hidden=true' | cat /usr/share/applications/ubuntu-amazon-default.desktop - > ~/.local/share/applications/ubuntu-amazon-default.desktop