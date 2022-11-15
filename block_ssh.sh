#!/bin/bash

OS=$(cat /etc/*elease | rpm --eval '%{centos_ver}')

if [ $OS == 7 ]; then
    systemctl start firewalld
    firewall-cmd --zone=work --add-source=118.70.126.121/24 --permanent
    firewall-cmd --zone=work --add-source=95.111.200.151/24 --permanent
    firewall-cmd --reload
    firewall-cmd --zone=work --add-service=ssh --permanent
    firewall-cmd --reload
    firewall-cmd --zone=public --remove-service=ssh --permanent
    firewall-cmd --zone=public --remove-port=22/tcp --permanent
    firewall-cmd --zone=public --remove-port=22/udp --permanent
    firewall-cmd --reload
else
    iptables -A INPUT -p tcp --dport 22 -s 118.70.126.121 -j ACCEPT
    iptables -A INPUT -p tcp --dport 22 -s 95.111.200.151 -j ACCEPT
    iptables -A INPUT -p tcp --dport 22 -j DROP
    iptables-save > /etc/sysconfig/iptables
    service iptables restart
fi