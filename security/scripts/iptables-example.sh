#!/bin/bash

#----------------------#
#SECTION INTERFACE ETH01
#----------------------#

IPS_LIBERADOS=""

IPS_LIBERADOS_WEB=""

IPS_LIBERADOS_DB=""

IPS_LIBERADOS_SSH=""

# LO / ESTABLISHED / RELATED / ICMP 

iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -s 0/0 -d 0/0 -p icmp -j ACCEPT

#Libera Geral
        echo "Liberando acesso total para os ips..."
        for IP in $IPS_LIBERADOS
        do
                echo  $IP
                iptables -A INPUT -s $IP -j ACCEPT
        done
        echo


#Libera DB
        echo "Liberando DB."
        for IP in $IPS_LIBERADOS_DB
        do
                echo  $IP
                iptables -A INPUT -s $IP -d  -p tcp --dport 3306 -j ACCEPT
        done
        echo

#Libera SSH
        echo "Liberando SSH"
        for IP in $IPS_LIBERADOS_SSH
        do
                echo  $IP
                iptables -A INPUT -s $IP -d  -p tcp --sport 1024:65535 --dport 22 -j ACCEPT
        done
        echo

#Libera WEB
        echo "Liberando WEB"
        for IP in $IPS_LIBERADOS_WEB
        do
                echo  $IP
                iptables -A INPUT -s $IP -d  -p tcp --sport 1024:65535 --dport 80 -j ACCEPT
        done
        echo



#Serviços individuais 



#----------------------#
#SECTION INTERFACE ETH02
#----------------------#



#----------------------#
#SECTION INTERFACE ETH03
#----------------------#


#DROP ALL

iptables -P INPUT DROP
iptables -P FORWARD DROP
