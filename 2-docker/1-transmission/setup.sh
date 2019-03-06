#!/bin/bash
#
# Install transmission

echo -e "\e[1m[docker/transmission] \e[0m\e[96minstall transmission\e[0m"
tput smcup
# Ask for root directory
TRANSMISSION_ROOT="$HOME/transmission"
read -p "Enter desired transmission root directory (default $TRANSMISSION_ROOT): " USER_ROOT
if [[ ! -z "$USER_ROOT" ]]; then
    TRANSMISSION_ROOT="$USER_ROOT"
fi
mkdir -p $TRANSMISSION_ROOT/data $TRANSMISSION_ROOT/downloads $TRANSMISSION_ROOT/watch

# Copy config file
cp ./settings.json "$TRANSMISSION_ROOT/data/"

# Acquire current user GID
GID=$(id -g "$USER")

# Acquire system TimeZone
TZ=$(cat /etc/timezone)

# create docker network to run transmission
docker network create -d bridge transmission-network

# create container for transmission
docker create --name=transmission \
              --restart=unless-stopped \
              --network=transmission-network \
              -v $TRANSMISSION_ROOT/data:/config \
              -v $TRANSMISSION_ROOT/downloads:/downloads \
              -v $TRANSMISSION_ROOT/watch:/watch \
              -e PGID=$UID \
              -e PUID=$GID \
              -e TZ=$TZ \
              -p 51413:51413 -p 51413:51413/udp linuxserver/transmission

# build image for stig
docker build -t stig .

# enable in firewall
sudo ufw allow 51413/tcp
sudo ufw allow 51413/udp
sudo ufw reload

# add stig alias in .bash_alias
ALIAS_FILE=$HOME/.bash_alias
sed -i "/alias stig=/d" $ALIAS_FILE
echo "alias stig=\"docker run -it --rm --network=transmission-network stig stig set connect.host transmission\"" >> $ALIAS_FILE
source $ALIAS_FILE

# start container
docker start transmission
tput rmcup
