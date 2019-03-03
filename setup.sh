#!/bin/bash
#
# Initialize the system

# fetch dialog
echo -e "\e[1m[setup] \e[0m\e[96minstall dialog\e[0m"
tput smcup
sudo apt install -y dialog
tput rmcup

# prompt user to choose subtasks
CHOICES=$(./tasks.sh `pwd` "Choose initialization tasks")

# invoke all subtasks chosen
for task in $CHOICES ; do
    dir=$(dirname "$task")
    echo -e "\e[1m[setup] \e[0m\e[96menter $dir\e[0m"
    pushd "$dir" >/dev/null
    ./setup.sh
    popd >/dev/null
done
