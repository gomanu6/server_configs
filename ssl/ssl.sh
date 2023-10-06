#!/bin/bash



apt update

# install dependencies
apt install -y curl gnupg2 software-properties-common ca-certificates apt-transport-https


#install docker on debian 12 (bookworm)

## uninstall old packages
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do apt remove $pkg; done


# Add Docker's official GPG key:

install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
# echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian bookworm stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt update

# Install Docker Engine
apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin



apt install certbot python3-certbot-nginx


certbot certonly --manual -d vw.starblaster.duckdns.org --preferred-challenges dns

https://www.duckdns.org/update?domains=starblaster&token=b322d413-c146-4e6f-833c-113c24c1d182&txt=QG44XSM5tVe72z1bDV08FLZ7_LQw7BQxAd_x5TJWM68&verbose=true&clear=true

https://www.duckdns.org/update?domains=starblaster&token=b322d413-c146-4e6f-833c-113c24c1d182&txt=k1_xZZarBfJBVAIIWSMqG95nQ7QNWus-RQa1q--hVf0&verbose=true&clear=true



k1_xZZarBfJBVAIIWSMqG95nQ7QNWus-RQa1q--hVf0