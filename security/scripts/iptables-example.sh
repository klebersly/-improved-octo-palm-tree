#!/bin/bash

#----------------------#
#SECTION INTERFACE ETH01
#----------------------#

IPS_LIBERADOS="192.168.65.98/32 192.168.65.81/32 189.45.192.150/32 189.45.192.13/32"

IPS_LIBERADOS_WEB="189.45.192.10/32 189.45.192.189/32 187.85.160.181/32 192.168.65.58/32 192.168.65.58/32 189.45.192.56/32 189.45.192.28/32 189.45.205.210/32 186.209.29.217/32 189.90.48.131/32 177.101.97.142/32 179.127.166.107/32 177.54.10.2/32 186.226.151.254/32 186.226.144.40/32 187.85.161.124/32 189.45.207.61/32 186.225.1.45/32 189.45.192.132/32 186.225.1.45/32 189.45.192.132/32 177.101.120.162/32 177.200.213.94/32 186.209.29.89/32 179.127.166.154/32 186.209.29.198/32 186.209.29.62/32 177.101.120.130/32 189.45.198.25/32 186.237.112.17/32 177.73.136.220/32 138.204.63.218/32 186.226.156.35/32 138.204.62.130/32 187.85.171.130/32 179.109.47.0/24 189.45.192.158/32 189.45.192.14/32 189.45.192.177/32 187.85.170.86/32 177.73.140.2/32 189.45.192.4/32 187.85.161.250/32 189.45.192.135/32 179.127.166.66/32 189.45.192.39/32 177.67.200.11/32 187.45.96.40/32 189.45.192.131/32 179.190.120.105/32 189.45.192.175/32 189.45.192.6/32 187.85.161.208/28"

IPS_LIBERADOS_DB="189.45.192.28/32 187.85.161.124/32 189.45.192.158/32 189.45.192.147/32 177.54.0.66/32 189.45.192.62/32 189.45.192.27/32 189.45.192.11/32 189.45.192.25/32 189.45.192.44/32 189.45.192.14/32 177.200.200.217/32 10.90.0.21/32 192.168.65.92/32"

IPS_LIBERADOS_SSH="189.45.192.56/32 189.45.192.158/32 189.45.192.4/32 187.85.161.250/32 179.127.166.66/32 192.168.65.89/32"

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
                iptables -A INPUT -s $IP -d 189.45.192.10 -p tcp --dport 3306 -j ACCEPT
        done
        echo

#Libera SSH
        echo "Liberando SSH"
        for IP in $IPS_LIBERADOS_SSH
        do
                echo  $IP
                iptables -A INPUT -s $IP -d 189.45.192.10 -p tcp --sport 1024:65535 --dport 22 -j ACCEPT
        done
        echo

#Libera WEB
        echo "Liberando WEB"
        for IP in $IPS_LIBERADOS_WEB
        do
                echo  $IP
                iptables -A INPUT -s $IP -d 189.45.192.10 -p tcp --sport 1024:65535 --dport 80 -j ACCEPT
        done
        echo



#Serviços individuais 

iptables -I INPUT -i eth0 -s 0/0 -d 189.45.192.10 -p tcp -m multiport --sport 113,90,81,995,143,22,9200,443,8080,8083,8086,25,587,465 -j ACCEPT
iptables -A INPUT -i eth0 -s 0/0 -d 189.45.192.10 -p tcp --sport 1024:65535 --dport 113 -j ACCEPT
iptables -A INPUT -i eth0 -s 177.200.200.225  -p tcp --sport 4190 --dport 1024:65535 -j ACCEPT
iptables -A INPUT -i eth0 -s 54.232.82.151 -d 189.45.192.10 -p tcp --sport 1984 -j ACCEPT
iptables -A INPUT -i eth0 -s 189.45.192.4 -d 189.45.192.10 -p tcp --sport 1024:65535 --dport 1024:65535 -j ACCEPT 
iptables -A INPUT -i eth0 -s 179.127.166.66 -d 189.45.192.10 -p tcp --sport 1024:65535 --dport 1024:65535 -j ACCEPT 
iptables -A INPUT -i eth0 -s 187.85.161.123 -d 189.45.192.10 -p tcp --sport 7557 --dport 1024:65535 -j ACCEPT

#----------------------#
#SECTION INTERFACE ETH02
#----------------------#

iptables -I INPUT -s 192.168.67.0./24 -d 0/0 -j ACCEPT
iptables -I INPUT -s 192.168.65.99 -d 192.168.67.251 -p tcp --sport 9200 --dport 1024:65535 -j ACCEPT
iptables -I INPUT -s 0/0 -d 192.168.67.251 -p tcp --sport 110 --dport 1024:65535 -j ACCEPT
iptables -I INPUT -s 0/0 -d 192.168.67.251 -p tcp --sport 8060 --dport 1024:65535 -j ACCEPT

#----------------------#
#SECTION INTERFACE ETH03
#----------------------#

iptables -I INPUT -i eth3 -s 0/0 -d 192.168.65.80 -p tcp -m multiport --sport 5046,5445,5044 -j ACCEPT
iptables -I INPUT -i eth3 -s 192.168.65.241 -d 192.168.65.80 -p tcp -m multiport --sport 1433,12433 -j ACCEPT
iptables -I INPUT -i eth3 -s 192.168.65.45 -d 192.168.65.80 -p tcp -m multiport --sport 80,8083 -j ACCEPT
iptables -I INPUT -i eth3 -s 192.168.65.158 -d 192.168.65.80 -p tcp  --sport 8289 -j ACCEPT
iptables -I INPUT -i eth3 -s 192.168.65.89 -d 192.168.65.80 -p tcp --sport 1024:65535 --dport 22 -j ACCEPT
iptables -I INPUT -i eth3 -s 0/0 -d 192.168.65.80 -p tcp  --sport 3306 --dport 1024:65535 -j ACCEPT
iptables -I INPUT -i eth3 -s 192.168.65.47 -d 192.168.65.80 -p tcp --sport 389 --dport 1024:65535 -j ACCEPT

#DROP ALL

iptables -P INPUT DROP
iptables -P FORWARD DROP
