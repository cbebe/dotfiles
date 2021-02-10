#!/bin/sh
cd $HOME
tar cf vmondem.tar.gz isaic_vm_on_demand/
scp -P $SSH_PORT vmondem.tar.gz ubuntu@vmondemand:
ssh -p $SSH_PORT ubuntu@vmondemand 'cd /home/ubuntu/ && tar xf vmondem.tar.gz'
cd - >/dev/null
