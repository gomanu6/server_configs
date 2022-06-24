
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

ufw default deny incoming
ufw default allow outgoing

#### Syntax

ufw allow|deny in|out port[/protocol] from any|ipaddress to any|ipaddress|port_no comment 'Comment'
if in|out is missing it creates a bi-directional rules that allows in bound and outbound traffic

ufw delete deny 53
ufw delete rule_number
