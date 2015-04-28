#!/bin/sh

DOMAIN=$1
DMAIL="jasan+dmarc"
DKEY="default._domainkey"

myrw() {
cat >> /etc/postfix/virtual <<EOF
$DMAIL@$DOMAIN jasan
EOF

postmap /etc/postfix/virtual

echo "Add to mydestination in /etc/postfix/main.conf"
read enter

cat >> /etc/opendkim/KeyTable <<EOF
$DKEY.$DOMAIN $DOMAIN:default:/etc/opendkim/keys/default.private
EOF

cat >> /etc/opendkim/SigningTable <<EOF
*@$DOMAIN $DKEY.$DOMAIN
EOF
}

myrw

cat <<EOF
@                  IN MX  10 mail.apiary-internal.com
@                  IN TXT "v=spf1 mx -all"
_dmarc             IN TXT "v=DMARC1; p=none; rua=mailto:$DMAIL@$DOMAIN"
$DKEY     IN TXT "p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDJ+UkZV21r/+K3cTK9ahBkTuNF3jF68wouTnbU+83n1iS+1CpzGPBOE3VWuwrSs1HRTNz01xo7DuR740Z8AdWaXCdC6msjxAZemQEDklzmmAZkDlnaER9vTBs8QQrCZZt4ULr8MCTaI6Ov51Wq6Yq+6ZkDwOxEWREit0+E0EZ0LQIDAQAB"
EOF
