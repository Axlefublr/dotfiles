#!/usr/bin/env fish

sudo apt install -y fish
chsh -s /usr/bin/fish
mkdir -p /etc/fish
ln -sf ~/Programming/dotfiles/fish/config.fish /etc/fish/config.fish