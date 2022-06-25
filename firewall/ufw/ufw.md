
Rules are evaluated from top to bottom



ufw status
ufw status verbose
ufw status numbered


ufw enable/disable

ufw allow 80


ufw reload
restarts the firewall with all the rules in place

ufw reset
removes any custom configs and restores to factory defaults

#### Default Rules
ufw default deny incoming
ufw default allow outgoing

#### Syntax

ufw allow|deny in|out port[/protocol] from any|ipaddress to any|ipaddress|port_no comment 'Comment'
if in|out is missing it creates a bi-directional rules that allows in bound and outbound traffic

ufw deny out from any to ipaddress
ufw allow from ipaddress to port no


ufw delete deny 53
ufw delete rule_number


#### Application Profile
- groups application and port information together
- uses INI file structure
- each section of the file contains a series of name value pair that represent a config item and its setting
- application profiles are stored in 
    - /etc/ufw/applications.d
- view list of available applications
    - ufw app list
- details of app profile
    -ufw app info samba
    - ufw app info 'Apache Secure'
- update the profiles
    - ufw app update app_name
    - ufw app update apache
- Use the app rules
    - ufw allow 'Apache Secure'


[Apache dual Ports]
title=Dual Port Apache Web Server
description=Apache Web Server config
ports=80,443/tcp

ufw allow Apache dual Ports


#### Rate Limit
- limit on the number of concurrent innbound connections
- 6 or more connections in the last 30 seconds
- allow reate limiting
    - ufw limit ssh



#### Logging and Monitoring

- log is stored in 
    - /var/log/ufw.log
- control logging 
    - ufw logging medium
    - low, medium, high, full

#### Testing
- netcat
    - opens socket connections between systems
- nmap
    - tests ports
    - nmap -sT -p 80,443 192.168.0.12




