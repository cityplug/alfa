#!/bin/bash

# Debian 8GB - (portainer.alfa.cityplug.io) setup script.

# apt update && apt install git -y && cd /opt && git clone https://github.com/cityplug/alfa && apt full-upgrade -y && chmod +x /opt/alfa/portainer/run.sh && reboot
# mv /opt/alfa/portainer/ /opt && rm -rf /opt/alfa/ && cd /opt/portainer && ./run.sh

# --- Install Packages
apt update && apt full-upgrade -y
apt install ca-certificates curl gnupg cifs-utils -y

# --- Install Docker & Docker Compose 
curl -sSL https://get.docker.com/ | sh && apt install docker-compose -y

# --- Portainer Main service
docker run -d -p 9000:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /env/appdata/portainer:/data portainer/portainer-ce:latest

# --- Addons
rm -rf /etc/update-motd.d/* && rm -rf /etc/motd
mv /opt/alfa/portainer/10-uname /etc/update-motd.d/ && chmod +x /etc/update-motd.d/10-uname

#--
systemctl enable docker 
docker-compose --version && docker --version
#--------------------------------------------------------------------------------