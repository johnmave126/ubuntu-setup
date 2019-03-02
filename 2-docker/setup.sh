#!/bin/bash
#
# Install docker and related containers

# From https://docs.docker.com/install/linux/docker-ce/ubuntu/

# Ask user what containers to create
CHOICES=$(../tasks.sh `pwd` "Choose Docker containers to create")

# Install packages to allow apt to use a repository over HTTPS:
sudo apt install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

# Add Docker’s official GPG key:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Use the following command to set up the stable repository.
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# Add current user to docker group
sudo usermod -aG docker $USER

# create containers
for task in $CHOICES ; do
    dir=$(dirname "$task")
    pushd "$dir"
    ./setup.sh
    popd
done
