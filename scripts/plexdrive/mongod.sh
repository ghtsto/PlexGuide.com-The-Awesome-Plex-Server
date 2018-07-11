#!/bin/bash

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6 1>/dev/null 2>&1
echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list 1>/dev/null 2>&1
yes | apt-get update 1>/dev/null 2>&1
yes | apt-get install -y mongodb-org 1>/dev/null 2>&1

## Enable Mongod Service
systemctl daemon-reload 1>/dev/null 2>&1
systemctl enable mongod 1>/dev/null 2>&1
systemctl start mongod 1>/dev/null 2>&1

echo 'INFO - Mongo for PlexDrive 4 Deployed' > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh

## Install Mongod Program
#apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5 1>/dev/null 2>&1
#echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list 1>/dev/null 2>&1
#yes | apt-get update 1>/dev/null 2>&1
#yes | apt-get install -y mongodb-org 1>/dev/null 2>&1

## Enable Mongod Service
#systemctl daemon-reload
#systemctl enable mongod 1>/dev/null 2>&1
#systemctl start mongod 1>/dev/null 2>&1


