#!/bin/sh

DOMAIN=$1
DMAIL="jasan+dmarc"

myrw() {
cat >> /etc/postfix/virtual <<EOF
$DMAIL@$DOMAIN jasan
EOF

postmap /etc/postfix/virtual

echo "Add to mydestination in /etc/postfix/main.conf"
read enter

cat >> /etc/opendkim/KeyTable <<EOF
default._domainkey.$DOMAIN $DOMAIN:default:/etc/opendkim/keys/default.private
EOF

cat >> /etc/opendkim/SigningTable <<EOF
*@$DOMAIN default._domainkey.$DOMAIN
EOF
}

myrw

cat <<EOF
mail.apiary-internal.com
v=spf1 mx -all
_dmarc
v=DMARC1; p=none; rua=mailto:$DMAIL@$DOMAIN

default._domainkey
p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDJ+UkZV21r/+K3cTK9ahBkTuNF3jF68wouTnbU+83n1iS+1CpzGPBOE3VWuwrSs1HRTNz01xo7DuR740Z8AdWaXCdC6msjxAZemQEDklzmmAZkDlnaER9vTBs8QQrCZZt4ULr8MCTaI6Ov51Wq6Yq+6ZkDwOxEWREit0+E0EZ0LQIDAQAB
EOF
