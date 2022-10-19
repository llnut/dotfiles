#!/bin/bash

INPUT_DEV=eth0
OUTPUT_DEV=wlan0
IP=$(ip addr | grep -A 1 $INPUT_DEV | grep inet | awk -F ' ' '{print $2F}' | awk -F '/' '{print $1F}')
[ -e $IP ] && echo "${INPUT_DEV}'s ip not set yet." && exit 1

sudo sysctl net.ipv4.ip_forward=1

sudo iptables -t nat -F POSTROUTING
sudo iptables -t nat -A POSTROUTING -o $OUTPUT_DEV -j MASQUERADE

sudo iptables -F FORWARD
sudo iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i $INPUT_DEV -o $OUTPUT_DEV -j ACCEPT

sudo ip route del default via $IP
