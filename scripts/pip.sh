#!/usr/bin/bash

sudo pacman -Syu --noconfirm python3
sudo pacman -S --noconfirm python-pip
sudo pacman -S --noconfirm python-pipx
pipx install termdown

pipx install yt-dlp
ln -sf ~/prog/dotfiles/yt-dlp.conf ~/yt-dlp.conf