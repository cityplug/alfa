#### Delete local-lvm 
    Select Datacentre
    Select Storage
    Remove local-lvm
#### Partition drive space allocation
    Select sever name alfa
    Enter shell
### Run the following
lvremove /dev/pve/data
lvresize -l +100%FREE /dev/pve/root
resize2fs /dev/mapper/pve-root
------------------------------------------------------------------------------
### Add the following line to grub for PCIE passthrough
nano /etc/default/grub
    GRUB_CMDLINE_LINUX_DEFAULT="quiet intel_iommu=on"
update-grub
update-initramfs -u
reboot
------------------------------------------------------------------------------
### Initialze disks
    Select sever name alfa
    Select Disks
    Select nvme0n1 and wipe disk
    Select Directory and Create Directory
        Filesystem: ext4
        Name: NVMe
------------------------------------------------------------------------------
### Initialze disks for ZFS Pool
    Select sever name alfa
    Enter shell
### Run the following
zfs create Vault/isos
zfs create Vault/vm-drives
zpool list
------------------------------------------------------------------------------
# Szxs9876@@
chown -R focal:focal /DEX720q
/alfa/
    /appdata/
        docker/
    /libraries/
        media/
        tools/
        downloads/
    /backup/
        configs/
        servers/
------------------------------------------------------------------------------
100-OPNsense.router
1001-ubuntu.desktop

102-library
103-pihole
201-tailscale
202-unifi
203-docker(homer,uptime-kuma,jdownloader,watchtower)
204-bigcapital
apt install parted -y
parted /dev/nvme0n1 mklabel gpt
parted -a opt /dev/nvme0n1 mkpart primary ext4 0% 100%
mkfs.ext4 -L nvme-centre /dev/nvme0n1p1
lsblk -fs
mkdir -p /mnt/nvme-centre
nano /etc/fstab 
    LABEL=nvme-centre /mnt/nvme-centre ext4 defaults 0 2
mount -a
------------------------------------------------------------------------------
--------------------------------------------------------------------------------
#### Grant new user account with privileges & assign new privileges
    sudo usermod -aG sudo,root focal && sudo visudo
#### Add the following underneath User privilege specification 
        focal	ALL=(ALL:ALL) ALL 
#### Add the following to the bottom of file under includedir /etc/sudoers.d 
        focal ALL=(ALL) NOPASSWD: ALL
#### Copy ssh key to server
    sudo su
    mkdir -p /home/focal/.ssh/ && touch /home/focal/.ssh/authorized_keys
    curl https://github.com/cityplug.keys >> /home/focal/.ssh/authorized_keys
#### Secure SSH Server by changing default port
    nano -w /etc/ssh/sshd_config
#### Find the line that says “#Port 22” and change it to desired port 
#### Scroll down until you find the line that says “PermitRootLogin” and change to “no” 
#### PermitRootLogin “no”
#### Scroll down further and find “PasswordAuthentication” and again change to “no” 
#### PasswordAuthentication “no”
    apt update && apt full-upgrade -y && reboot
--------------------------------------------------------------------------------
### Run the following scripts
    sudo su
    cd /opt && apt install git -y && git clone https://github.com/cityplug/relay && chmod +x relay/.scripts/*
------------------------------------------------------------------------------
### Run the following scripts
    cd relay/.scripts/ && ./start.sh
    sudo su
    cd /opt/relay/.scripts/ && ./security-samba.sh
--------------------------------------------------------------------------------
    docker exec zerotier zerotier-cli join 8bd5124fd6badc1f
--------------------------------------------------------------------------------
    echo "
    interface eth0
    static ip_address=192.168.50.254/24
    static routers=192.168.50.1" >> /etc/dhcpcd.conf
------------------------------------------------------------------------------
#### Host Machine
    echo "
    net.ipv4.ip_forward = 1
    net.ipv6.conf.all.forwarding = 1" >> /etc/sysctl.conf