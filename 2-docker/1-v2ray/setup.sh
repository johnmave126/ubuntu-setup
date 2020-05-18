#!/bin/bash
#
# Install V2RAY VPN server

V2RAY_DATA="v2ray-data"

echo -e "\e[1m[docker/v2ray] \e[0m\e[96minstall V2RAY\e[0m"
# Ask for preshared key
USER_COUNT=''
while [[ -z "$USER_COUNT" ]]; do
    read -p "Enter number of users to create: " USER_INPUT
    echo ''
    if [[ -z "$USER_INPUT" || "$USER_INPUT" -le 0 ]]; then
        echo "Must have at least 1 user"
    else
        USER_COUNT="$USER_INPUT"
    fi
done

TMPFILE=`mktemp -t XXXXXXXX.json`
cat >$TMPFILE <<EOF
{
  "inbounds": [
    {
      "port": 5000,
      "listen":"0.0.0.0",
      "protocol": "vmess",
      "settings": {
        "clients": [
EOF

for ((i=1; i<=USER_COUNT; i++))
do
    cat >>$TMPFILE <<EOF
          {
            "id": "$(cat /proc/sys/kernel/random/uuid)",
            "alterId": 12
          }
EOF
    if [[ "$i" -lt "$USER_COUNT" ]]; then
        echo , >>$TMPFILE
    fi
done
cat >>$TMPFILE <<EOF
        ],
        "disableInsecureEncryption": true
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": {
          "path": "/universe"
        }
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    }
  ]
}
EOF

# create volume for config file
docker volume create --name $V2RAY_DATA
# create container
docker create --name=v2ray \
              --restart=unless-stopped \
              -v $V2RAY_DATA:/etc/v2ray:ro \
              v2fly/v2fly-core
docker network connect nginx-certbot-network v2ray
docker cp $TMPFILE v2ray:/etc/v2ray/config.json

# start container
docker start v2ray

echo -e "\e[1m[docker/v2ray] \e[0m\e[96mdone\e[0m"
