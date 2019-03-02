#!/bin/bash
#
# Initialize the system

# fetch dialog
sudo apt install -y dialog

# prompt user to choose subtasks
CHOICES=$(./tasks.sh `pwd` "Choose initialization tasks")

# invoke all subtasks chosen
for task in $CHOICES ; do
    dir=$(dirname "$task")
    echo -e "\e[1;96mEnter $dir\e[0m"
    pushd "$dir"
    ./setup.sh
    popd
done