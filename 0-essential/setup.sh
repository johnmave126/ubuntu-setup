#!/bin/bash
#
# Basic system preparation

# Install basic packages
echo -e "\e[1m[essential] \e[21;96minstall essential packages\e[0m"
tput smcup
sudo apt install -y build-essential cmake curl python python3-dev gnupg ca-certificates net-tools ssh iotop
tput rmcup


# remove Chinese and Quovadis certificates from ca-certificates
echo -e "\e[1m[essential] \e[21;96mremove untrusted certificates\e[0m"
tput smcup
# To match line in /etc/ca-certificates.conf
BAD_CERT="QuoVadis_Root_CA"
# To match subject line of a certificate
BAD_CERT_SUBJECT="C = CN"
TMPFILE="/tmp/ca-certificates.conf"
# Create temp file
: > $TMPFILE
# Read everything from /etc/ca-certificates.conf
while IFS='' read -r line || [[ -n "$line" ]]; do
    if [[ "$line" =~ ^[#!] ]]; then
        # Ignore comments and deselected certificates
        echo "$line" >> $TMPFILE
    elif [[ "$line" =~ $BAD_CERT ]]; then
        # Deselect certificate
        echo "!$line" >> $TMPFILE
    else
        # Find name of the certificate
        CERTFILE="/usr/share/ca-certificates/$line"
        CERTSUBJECT=''
        if [[ -f $CERTFILE ]]; then
            # certificate exists, send it to openssl for verification
            CERTSUBJECT=$(openssl x509 -subject -noout -in "$CERTFILE")
        fi
        if [[ "$CERTSUBJECT" =~ $BAD_CERT_SUBJECT ]]; then
            echo "!$line" >> $TMPFILE
        else
            echo "$line" >> $TMPFILE
        fi
    fi
done < /etc/ca-certificates.conf

# Apply changes
sudo mv "$TMPFILE" /etc/ca-certificates.conf
sudo update-ca-certificates
tput rmcup
echo -e "\e[1m[essential] \e[21;96mdone\e[0m"
