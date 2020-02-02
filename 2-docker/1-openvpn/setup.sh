#!/bin/bash
#
# Install OpenVPN server

echo -e "\e[1m[docker/openvpn] \e[0m\e[96minstall OpenVPN\e[0m"
tput smcup

read -p "Enter domain name: " DOMAIN

# Setup volume
OVPN_DATA="openvpn-data"
IMAGE="kylemanna/openvpn"
docker volume create --name $OVPN_DATA
docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm $IMAGE ovpn_genconfig -u udp://$DOMAIN
docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm -it $IMAGE ovpn_initpki

# Start Server
docker create --name=openvpn \
              --restart=unless-stopped \
              -v $OVPN_DATA:/etc/openvpn \
              -p 1194:1194/udp \
              --cap-add=NET_ADMIN \
              $IMAGE

sudo ufw allow 1194/udp
sudo ufw reload

# start container
docker start openvpn
tput rmcup

# add client generation script
CURRENT_DIR=`pwd`
../../add-alias.sh generate-ovpn-client "$CURRENT_DIR/generate-ovpn-client"
echo -e "\e[1m[docker/openvpn] \e[0m\e[96mdone\e[0m"
