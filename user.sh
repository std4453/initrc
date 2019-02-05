#!/bin/false

# This script is used to setup workspace of the new user.
# This script should not be executed directly.
# At execution point of this script, the current user should
# be the new user, the interpreter should be bash, and these
# variables shoule be available:
#   color_green color_red color_reset new_user_name

set -e

curl -L https://get.oh-my.fish | fish
omf install agnoster

curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
sleep 10 # wait until fisher is available
fisher add jorgebucaran/fish-nvm
nvm use latest
npm i -g http-server npx

fish "set -Ux PAGER most"

