#!/usr/bin/env bash

# Target System: Digital Ocean + Ubuntu 18.10

# Variables
color_green="\033[32m"
color_red="\033[31m"
color_reset="\033[0m"
new_user_name="std4453"

echo -e "========PREPARE STAGE========"
cd
[[ $EUID != 0 ]] && echo -e "${color_red}ERROR: Not running as root!${color_reset}" && exit 1
apt-get update
apt-get upgrade -y

echo -e "========SETUP NEW USER========"
useradd -m ${new_user_name}
echo -e "${color_green}Enter password for new user:${color_reset}"
passwd ${new_user_name}
if [ ! -f ~/.ssh/authorized_keys ]; then
	cd /home/${new_user_name}
	mkdir -p .ssh
	cp ~/.ssh/authorized_keys .ssh/
	chown ${new_user_name}:${new_user_name} .ssh/authorized_keys
	cd
fi
usermod -aG sudo std4453

echo -e "========SETUP FISH SHELL========"
apt-get install git software-properties-common -y
apt-add-repository ppa:fish-shell/release-3 -y
apt-get update
apt-get install fish -y
chsh -s "$(which fish)" ${new_user_name}

