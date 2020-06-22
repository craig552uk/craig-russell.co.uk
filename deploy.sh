#!/bin/bash
TSTART=`date +%s`

SSH=root@mustardhr.uk
FILE=/srv/nginx/html/craig-russell.co.uk

rm -rvf _site/ &&
npm run build &&
git push origin master &&
tar -c -f /tmp/craig-russell.co.uk.tar _site/* &&
scp /tmp/craig-russell.co.uk.tar $SSH:/srv/nginx/html/ &&
ssh $SSH "rm -rf $FILE.bak && mv $FILE $FILE.bak && mkdir $FILE && tar -xf $FILE.tar -C $FILE/" &&
echo "Deployed website https://craig-russell.co.uk in "$((`date +%s`-$TSTART))" seconds";
