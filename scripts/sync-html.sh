#!/bin/sh
cd ~/ISAIC/VMonDemand
tar -cf html.tar.gz html
scp -P $SSH_PORT html.tar.gz ubuntu@vmondemand:/var/www
ssh -p $SSH_PORT ubuntu@vmondemand 'bash ~/unpack.sh'
cd -
