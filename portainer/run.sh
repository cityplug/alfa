#!/bin/bash

# Debian 8GB - (portainer.alfa.cityplug.io) setup script.

# cd /opt && apt update -y && apt install git curl gnupg cifs-utils -y && apt full-upgrade -y && git clone https://github.com/cityplug/alfa && reboot
# chmod +x /opt/alfa/portainer/* && mv /opt/alfa/portainer/ /opt && rm -rf /opt/alfa/ && cd /opt/portainer && ./run.sh

# --- Install Packages
apt update && apt full-upgrade -y
apt install ca-certificates curl gnupg cifs-utils -y

# --- Install Docker & Docker Compose 
curl -sSL https://get.docker.com/ | sh && apt install docker-compose -y

# --- Portainer & Uptime-kuma Services
docker run -d -p 9000:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /env/appdata/portainer:/data portainer/portainer-ce:latest
docker run -d -p 13001:3001 --name uptime-kuma --restart=always -v /env/appdata/uptime-kuma/data:/app/data elestio/uptime-kuma:latest

# --- Addons
rm -rf /etc/update-motd.d/* && rm -rf /etc/motd
mv /opt/alfa/portainer/10-uname /etc/update-motd.d/ && chmod +x /etc/update-motd.d/10-uname

#--
systemctl enable docker 
docker-compose --version && docker --version
#--------------------------------------------------------------------------------
