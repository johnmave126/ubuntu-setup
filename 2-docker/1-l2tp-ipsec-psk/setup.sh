#!/bin/bash
#
# Install L2TP/IPSEC-PSK VPN server

echo -e "\e[1m[docker/l2tp-ipsec-psk] \e[0m\e[96minstall L2TP/IPSEC-PSK\e[0m"
# Ask for preshared key
PSK=''
while [[ -z "$PSK" ]]; do
    read -s -p "Enter preshared key for the VPN: " USER_INPUT
    echo ''
    if [[ -z "$USER_INPUT" ]]; then
        echo "PSK required"
    else
        PSK="$USER_INPUT"
    fi
done

# Ask for username
USERNAME='vpnuser'
read -p "Enter username for the VPN (default: vpnuser): " USER_INPUT
if [[ ! -z "$USER_INPUT" ]]; then
    USERNAME="$USER_INPUT"
fi

# Ask for password
PASSWORD=''
while [[ -z "$PASSWORD" ]]; do
    read -s -p "Enter password for the VPN: " USER_INPUT
    echo ''
    if [[ -z "$USER_INPUT" ]]; then
        echo "password required"
    else
        PASSWORD="$USER_INPUT"
    fi
done

# create container
docker create --name=l2tp-ipsec-psk \
              --restart=unless-stopped \
              -e VPN_IPSEC_PSK=$PSK \
              -e VPN_USER=$USERNAME \
              -e VPN_PASSWORD=$PASSWORD \
              -v /lib/modules:/lib/modules:ro \
              --privileged \
              -p 4500:4500/udp -p 500:500/udp hwdsl2/ipsec-vpn-server

# enable in firewall
sudo ufw allow 500/udp
sudo ufw allow 4500/udp
sudo ufw reload

# start container
docker start l2tp-ipsec-psk

echo -e "\e[1m[docker/l2tp-ipsec-psk] \e[0m\e[96mdone\e[0m"
