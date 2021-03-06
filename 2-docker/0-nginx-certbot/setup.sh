#!/bin/bash
#
# Install NGINX and certbot
# adapted from https://medium.com/@pentacent/nginx-and-lets-encrypt-with-docker-in-less-than-5-minutes-b4b8a60d3a71

# start docker app
echo -e "\e[1m[docker/nginx-certbot] \e[0m\e[96minstall NGINX and certbot in a container\e[0m"
docker-compose up -d

# copy default site conf
echo -e "\e[1m[docker/nginx-certbot] \e[0m\e[96mcopy default files\e[0m"
docker cp default.conf nginx:/etc/nginx/conf.d/
docker exec nginx nginx -s reload

# download ssl parameters
TMPFILE=`mktemp -t XXXXXXXX.conf`
curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot-nginx/certbot_nginx/_internal/tls_configs/options-ssl-nginx.conf >$TMPFILE
docker cp $TMPFILE nginx:/etc/letsencrypt/options-ssl-nginx.conf
# clean up
rm -f $TMPFILE

TMPFILE=`mktemp -t XXXXXXXX.pem`
openssl dhparam -out $TMPFILE 2048
docker cp $TMPFILE nginx:/etc/letsencrypt/ssl-dhparams.pem
# clean up
rm -f $TMPFILE

# enable in firewall
echo -e "\e[1m[docker/nginx-certbot] \e[0m\e[96mset up firewall\e[0m"
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw reload

# add automatical domain creation tool to alias
CURRENT_DIR=`pwd`
../../add-alias.sh register-new-site "$CURRENT_DIR/register-new-site"
../../add-alias.sh create-docker-compose-boilerplate "$CURRENT_DIR/create-docker-compose-boilerplate"
echo -e "\e[1m[docker/nginx-certbot] \e[0m\e[96mdone\e[0m"
