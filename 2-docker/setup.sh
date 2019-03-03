#!/bin/bash
#
# Install docker and related containers

# From https://docs.docker.com/install/linux/docker-ce/ubuntu/

# Ask user what containers to create
CHOICES=$(../tasks.sh `pwd` "Choose Docker containers to create")

# Install packages to allow apt to use a repository over HTTPS:
echo -e "\e[1m[docker] \e[0m\e[96minstall docker pre-requisite\e[0m"
tput smcup
sudo apt install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
tput rmcup

# Add Docker’s official GPG key:
echo -e "\e[1m[docker] \e[0m\e[96madd docker GPG key and repo\e[0m"
tput smcup
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
tput rmcup

# Install docker
echo -e "\e[1m[docker] \e[0m\e[96minstall docker\e[0m"
tput smcup
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io
tput rmcup

# Add current user to docker group
sudo usermod -aG docker $USER
newgrp docker

# Install docker-compose
echo -e "\e[1m[docker] \e[0m\e[96minstall docker-compose\e[0m"
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# deny 2375 port
sudo ufw deny 2375/tcp

# create containers
for task in $CHOICES ; do
    dir=$(dirname "$task")
    pushd "$dir" >/dev/null
    ./setup.sh
    popd >/dev/null
done

echo -e "\e[1m[docker] \e[0m\e[96mdone\e[0m"
