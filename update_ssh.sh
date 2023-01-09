#!/bin/bash

OS=$(cat /etc/*elease | rpm --eval '%{centos_ver}')

if [ $OS == 7 ]; then
    firewall-cmd --zone=work --add-source=128.199.228.58/24 --permanent
    firewall-cmd --reload
else
    iptables -A INPUT -p tcp --dport 22 -s 128.199.228.58 -j ACCEPT
    iptables-save > /etc/sysconfig/iptables
    service iptables restart
fi

echo '128.199.228.58 added to zone work' > firewald.log
