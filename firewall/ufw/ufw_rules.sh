#!/bin/bash


ufw disable

ufw default deny incoming
ufw default deny forward
ufw default allow outgoing

ufw allow samba

# SSH 
ufw allow ssh
ufw allow 22/tcp
ufw limit ssh

# Samba Ports
ufw allow 137/udp from 192.168.0.1/24
ufw allow 138/udp from 192.168.0.1/24
ufw allow 139/tcp from 192.168.0.1/24
ufw allow 445/tcp from 192.168.0.1/24

ufw allow out ntp
ufw allow out 53

ufw allow svn
ufw allow git



ufw enable