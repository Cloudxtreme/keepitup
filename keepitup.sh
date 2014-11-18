#!/bin/sh

a="/$0"; a=${a%/*}; a=${a#/}; a=${a:-.}; BINDIR=`cd $a; pwd`
export PATH=$BINDIR:$PATH

cd $BINDIR/urls
while true
do
  cat * | while read url
    do
      echo "Getting URL $url ..."
      curl -k "$url" >/dev/null 2>&1
    done
  SLEEP=$((RANDOM%30+60))
  echo "Sleeping $SLEEP seconds..."
  sleep $SLEEP
done
