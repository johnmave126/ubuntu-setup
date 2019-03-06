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

# copy Dockerfile for stig
cp -rf ./Dockerfile "$TRANSMISSION_ROOT/"

# create docker-compose.yml in TRANSMISSION_ROOT
pushd "$TRANSMISSION_ROOT" > /dev/null
cat >docker-compose.yml <<EOF
version: '3.5'

services:
  transmission:
    image: linuxserver/transmission
    ports:
      - '51413:51413'
      - '51413:51413/udp'
    volumes:
      - $TRANSMISSION_ROOT/data:/config
      - $TRANSMISSION_ROOT/downloads:/downloads
      - $TRANSMISSION_ROOT/watch:/watch
    environment:
      PGID: '$UID'
      PUID: '$GID'
      TZ: '$TZ'
    restart: always
  stig:
    build: .
    container_name: stig
    depends_on:
      - transmission
EOF
# start container
docker-compose up -d
popd > /dev/null

# enable in firewall
sudo ufw allow 51413/tcp
sudo ufw allow 51413/udp
sudo ufw reload

tput rmcup
