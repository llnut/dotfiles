#!/bin/bash

#初始的时候:
iptables -t nat -I PREROUTING 1 -p tcp --dport 80 -j REDIRECT --to-port 8080

#切换的时候:
iptables -t nat -I PREROUTING 1 -p tcp --dport 80 -m state --state NEW -j REDIRECT --to-port 8081 

#等到转发到8080的连接都没了的时候:
iptables -t nat -I PREROUTING 1 -p tcp --dport 80 -j REDIRECT --to-port 8081 
