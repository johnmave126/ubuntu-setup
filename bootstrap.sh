#!/bin/bash
#
# Bootstrap to initialize system

# obtain sudo privilege
dummy=$(sudo whoami)

# install git
sudo apt update
sudo apt dist-upgrade -y
sudo apt install -y git

# pull whole setup repo
git clone https://github.com/johnmave126/ubuntu-setup.git
cd ubuntu-setup

# run actual setup script
./setup.sh
