#!/bin/bash
yum install -y nfs-utils
mkdir /shared
chmod 777 /shared
echo "/shared 172.16.*(rw,sync)" > /etc/exports
systemctl stop firewalld
ec2-metadata -o | cut -d ' ' -f 1 >> /shared/list.txt
chmod 777 /shared/list.txt

systemctl start nfs-server
