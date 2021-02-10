#!/bin/sh
ssh -p $SSH_PORT ubuntu@vmondemand 'cd /home/ubuntu/ && tar cf vmondem.tar.gz isaic_vm_on_demand'
scp -P $SSH_PORT ubuntu@vmondemand:vmondem.tar.gz $HOME
cd $HOME && tar xf $HOME/vmondem.tar.gz
cd - >/dev/null
