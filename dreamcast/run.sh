#!/bin/bash

# Debian 8GB - (dreamcast.alfa.cityplug.io) setup script.

# cd /opt && apt update -y && apt install git curl gnupg cifs-utils -y && apt full-upgrade -y && git clone https://github.com/cityplug/alfa && reboot
# chmod +x /opt/alfa/dreamcast/* && mv /opt/alfa/dreamcast/ /opt && rm -rf /opt/alfa/ && cd /opt/dreamcast && ./run.sh

# --- Install Docker & Docker Compose 
curl -sSL https://get.docker.com/ | sh && apt install docker-compose -y

# --- Portainer Agent service
docker run -d -p 9001:9001 --name portainer_agent --restart always -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/docker/volumes:/var/lib/docker/volumes portainer/agent:latest

# --- Addons
rm -rf /etc/update-motd.d/* && rm -rf /etc/motd
wget https://raw.githubusercontent.com/cityplug/alfa/main/10-uname -O /etc/update-motd.d/10-uname && chmod +x /etc/update-motd.d/10-uname
#mv /opt/alfa/dreamcast/10-uname /etc/update-motd.d/ && chmod +x /etc/update-motd.d/10-uname

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