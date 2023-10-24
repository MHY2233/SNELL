#!/bin/bash


# Install dependencies based on the Linux distribution
if cat /etc/*-release | grep -q -E -i "debian|ubuntu|armbian|deepin|mint"; then
    apt-get install wget unzip dpkg -y
elif cat /etc/*-release | grep -q -E -i "centos|red hat|redhat"; then
    yum install wget unzip dpkg -y
elif cat /etc/*-release | grep -q -E -i "arch|manjaro"; then
    pacman -S wget dpkg unzip --noconfirm
elif cat /etc/*-release | grep -q -E -i "fedora"; then
    dnf install wget unzip dpkg -y
fi

# Enable BBR
echo "net.core.default_qdisc=fq" | tee -a /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" | tee -a /etc/sysctl.conf
sysctl -p
sysctl net.ipv4.tcp_available_congestion_control

cd
ARCHITECTURE=$(uname -m)
wget -c https://dl.nssurge.com/snell/snell-server-v4.0.1-linux-$ARCHITECTURE.zip
unzip -o snell-server-v4.0.1-linux-$ARCHITECTURE.zip

# Create systemd service
echo -e "[Unit]\nDescription=snell server\n[Service]\nUser=$(whoami)\nWorkingDirectory=$HOME\nExecStart=$HOME/snell-server\nRestart=always\n[Install]\nWantedBy=multi-user.target" | tee /etc/systemd/system/snell.service > /dev/null
echo "y" | ./snell-server
systemctl start snell
systemctl enable snell

# Print profile
echo
echo "Copy the following line to surge"
echo "$(curl -s ipinfo.io/city) = snell, $(curl -s ipinfo.io/ip), $(cat snell-server.conf | grep -i listen | cut --delimiter=':' -f2),psk=$(grep 'psk' snell-server.conf | cut -d= -f2 | tr -d ' '), version=4, tfo=true"