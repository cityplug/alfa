#!/bin/bash

# Debian 128GB - (nextcloud.alfa.lab) setup script.

# apt update && apt install git -y && cd /opt && git clone https://github.com/cityplug/alfa && apt full-upgrade -y && chmod +x /opt/alfa/nextcloud/run.sh && reboot
# cd /opt/alfa/nextcloud && ./run.sh

# --- Install Packages
echo "#  ---  Installing New Packages  ---  #"
apt update && apt full-upgrade -y
apt install ca-certificates curl gnupg cifs-utils -y

# --- Install Docker & Docker Compose 
curl -sSL https://get.docker.com/ | sh
wget https://github.com/docker/compose/releases/download/v2.23.0/docker-compose-linux-x86_64 -O /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose && apt install docker-compose -y

# --- Portainer Agent service
docker run -d -p 9001:9001 --name portainer_agent --restart always -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/docker/volumes:/var/lib/docker/volumes portainer/agent:latest

# --- Addons
rm -rf /etc/update-motd.d/* && rm -rf /etc/motd
mv /opt/alfa/10-uname /etc/update-motd.d/ && chmod +x /etc/update-motd.d/10-uname

#--
systemctl enable docker 
docker-compose --version && docker --version
docker compose up -d
docker ps
--------------------------------------------------------------------------------