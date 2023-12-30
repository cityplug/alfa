#!/bin/bash

# Debian 8GB - (dreamcast.alfa.cityplug.io) setup script.

# apt update && apt install git -y && cd /opt && git clone https://github.com/cityplug/alfa && apt full-upgrade -y && chmod +x /opt/alfa/dreamcast/run.sh && reboot
# cd /opt/alfa/dreamcast && ./run.sh

# --- Install Packages
apt update && apt full-upgrade -y
apt install ca-certificates curl gnupg cifs-utils -y

# --- Install Docker & Docker Compose 
curl -sSL https://get.docker.com/ | sh && apt install docker-compose -y

# --- Portainer Agent service
docker run -d -p 9001:9001 --name portainer_agent --restart always -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/docker/volumes:/var/lib/docker/volumes portainer/agent:latest

# --- Addons
rm -rf /etc/update-motd.d/* && rm -rf /etc/motd
mv /opt/alfa/dreamcast/10-uname /etc/update-motd.d/ && chmod +x /etc/update-motd.d/10-uname

# -- Parent Folder
mkdir -p /env/appdata/ 

#--
systemctl enable docker 
docker-compose --version && docker --version
docker compose up -d
docker ps

# --- Build Homepage
docker stop homepage
rm -rf /env/appdata/homepage/
mv /opt/alfa/dreamcast/homepage /env/appdata/
docker start homepage
#--------------------------------------------------------------------------------