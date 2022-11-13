#!/bin/bash

# https://www.digitalocean.com/community/tutorials/how-to-configure-bind-as-a-private-network-dns-server-on-ubuntu-20-04


read -rp "Enter password : " -s password


# Install dependencies

echo "${password}" | sudo -S -v
sudo apt update

sudo apt install ssh samba samba-common software-properties-common apt-transport-https curl wget ca-certificates gnupg2 -y

# apt list --installed | grep "name"

## Remove packages
sudo apt remove transmission-gtk


## Install Google Chrome

### Import GPG Key
sudo wget -O- https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor | sudo tee /usr/share/keyrings/google-chrome.gpg


### Import Chrome Repository
echo deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main | sudo tee /etc/apt/sources.list.d/google-chrome.list

### Install Chrome
sudo apt update
sudo apt install google-chrome-stable -y


## Install Anydesk

### Add Key
curl -fsSL https://keys.anydesk.com/repos/DEB-GPG-KEY|sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/anydesk.gpg

### Add Repo
echo "deb http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list

### Install Anydesk
sudo apt update
sudo apt install anydesk


## Install HPLip
sudo apt install hplip hplip-gui



