#!/bin/bash
#
# Install transmission

echo -e "\e[1m[docker/transmission] \e[21;96minstall transmission\e[0m"
tput smcup
# Ask for root directory
TRANSMISSION_ROOT="$HOME/transmission"
read -p "Enter desired transmission root directory (default $TRANSMISSION_ROOT): " USER_ROOT
if [[ -z "$USER_ROOT" ]]; then
    TRANSMISSION_ROOT="$USER_ROOT"
fi
mkdir -p $TRANSMISSION_ROOT/data $TRANSMISSION_ROOT/downloads $TRANSMISSION_ROOT/watch

# Copy config file
cp ./settings.json "$TRANSMISSION_ROOT/data/"

# Acquire current user UID and GID
UID=$(id -u "$USER")
GID=$(id -g "$USER")

# Acquire system TimeZone
TZ=$(cat /etc/timezone)

# create container
docker create --name=transmission \
              --restart=unless-stopped \
              -v $TRANSMISSION_ROOT/data:/config \
              -v $TRANSMISSION_ROOT/downloads:/downloads \
              -v $TRANSMISSION_ROOT/watch:/watch \
              -e PGID=$UID \
              -e PUID=$GID \
              -e TZ=$TZ \
              -p 127.0.0.1:9091:9091 \
              -p 51413:51413 -p 51413:51413/udp linuxserver/transmission

# enable in firewall
sudo ufw allow 51413/tcp
sudo ufw allow 51413/udp
sudo ufw reload

# start container
docker start transmission
tput rmcup
