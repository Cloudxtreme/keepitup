FROM="Jan SARENIK"
TO="Jasan <jajomojo+pokus@gmail.com>"

mysend() {
sendmail -t -r $SENDER -bm <<EOF
From: Jan SARENIK <$SENDER>
To: Jasan <jajomojo+pokus@gmail.com>
Subject: Pokusna sprava pre DMARC

Ahoj Jasan! :-)
EOF
}

cat alldomains-without-apiaryio | while read domain
do
SENDER=jasan@$domain
echo Sending mail as $SENDER
mailx -t -r $SENDER <<EOF
From: $FROM <$SENDER>
To: $TO
Subject: $domain - Pokusna sprava pre DMARC $RANDOM

Ahoj Jasan!

Presne $RANDOM ludi bolo v nedelu na trhu! Skoda ze si tam nebol.
http://www.blesitrhy.cz/

Kvak.
EOF
done
