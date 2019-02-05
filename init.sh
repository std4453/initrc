#!/usr/bin/env bash

# Target System: Digital Ocean + Ubuntu 18.10

set -e

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

echo -e "========INSTALL FISH SHELL========"
# This only addes the fish ppa repo and install fish as root,
# further installation is done in user.sh
apt-get install software-properties-common -y
apt-add-repository ppa:fish-shell/release-3 -y
apt-get update
apt-get install fish -y

echo -e "========INSTALL OTHER PACKAGES========="
apt-get install git xsel xauth most vim tmux -y

echo -e "========SETUP NEW USER========"
useradd -m ${new_user_name}
echo -e "${color_green}Enter password for new user:${color_reset}"
passwd ${new_user_name}
# copy authorized keys to allow logging in by public key
if [ ! -f ~/.ssh/authorized_keys ]; then
	cd /home/${new_user_name}
	mkdir -p .ssh
	cp ~/.ssh/authorized_keys .ssh/
	chown ${new_user_name}:${new_user_name} .ssh/authorized_keys
	cd
fi
usermod -aG sudo std4453
# run chsh as root to avoid password prompt
chsh -s "$(which fish)" std4453
su -c "bash user.sh" ${new_user_name}

