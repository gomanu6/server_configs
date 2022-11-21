#!/bin/bash

# 
# https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-phpmyadmin-with-nginx-on-an-ubuntu-20-04-server

sudo apt install phpmyadmin



CREATE USER 'name'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON *.* TO 'name'@'localhost';
FLUSH PRIVILEGES;
exit
