#!/bin/bash -x

# This script is intended to run in a fresh Ubuntu 22 WSL environment 
# and add the necessary packages to have a nice Astro/VS Code/Docker-CE 
# development experience.

# Allow passwordless sudo
echo '%sudo  ALL=(ALL) NOPASSWD: ALL' | sudo tee -a /etc/sudoers

# Tell the package installer not to ask questions because this is a script
export DEBIAN_FRONTEND=noninteractive

# Remove Ubuntu docker pkgs
sudo apt-get remove -y docker docker-engine docker.io containerd runc

# Add standard devops packages
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository -y "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update
sudo apt-get install -y nmap bzip2 netcat net-tools git htop sysstat iotop vim-nox python3-pip jq lm-sensors \
  ca-certificates curl gnupg lsb-release terraform vault zstd

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor --yes -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo update-alternatives --set iptables /usr/sbin/iptables-legacy
sudo update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy
sudo usermod -G docker -a $USER

# Install Astronomer CLI
curl -sSL install.astronomer.io | sudo bash -s

set +x
echo '#'
echo '#'
echo '#'
echo '# YOU MUST REBOOT LINUX FOR THE DOCKER-CE IPTABLES CHANGE TO TAKE EFFECT!!!'
echo '#'
echo '# Reboot Windows, or in powershell run:'
echo '# wsl --shutdown'
echo '#'
echo '# Then open your WSL/Ubuntu shell again.'
echo '#'

