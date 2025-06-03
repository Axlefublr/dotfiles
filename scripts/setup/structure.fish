#!/usr/bin/env fish

mkdir -p ~/w \
    ~/i \
    ~/v \
    ~/r \
    ~/r/forks \
    ~/r/proj \
    ~/r/the \
    ~/trans \
    ~/.local/bin \
    ~/.cache/{mine,wks} \
    ~/.local/share/mine \
    ~/.local/share/{harp,loago}

mkfifo ~/.local/share/mine/waybar-cursor-mode

fish_add_path ~/.local/bin

cd ~
git clone https://github.com/Axlefublr/deleted-bangers m
git clone https://github.com/Axlefublr/autocommit auto

cd ~/i
git clone https://github.com/Axlefublr/pictures-tree e
git clone https://github.com/Axlefublr/twemoji-svg
git clone https://github.com/Axlefublr/video-creation-tools tools

cd ~/r
git clone https://github.com/Axlefublr/dotfiles dot
git clone https://github.com/Axlefublr/binaries
git clone https://github.com/Axlefublr/backup
git clone https://github.com/Axlefublr/info
git clone https://github.com/Axlefublr/job

fish_add_path ~/r/binaries
fish_add_path ~/r/binaries/wks
fish_add_path ~/r/dot/fish
fish_add_path ~/r/dot/fish/fun
fish_add_path ~/r/dot/scripts
fish_add_path ~/r/dot/scripts/trenchcoat
fish_add_path ~/r/dot/scripts/scriptister
fish_add_path ~/r/dot/scripts/fool
fish_add_path ~/r/dot/scripts/services

cd ~/r/forks
git clone https://github.com/Axlefublr/helix

cd ~/.local/share
cp -f ~/auto/harp.jsonc ~/.local/share/harp/harp.jsonc
cp -f ~/auto/loago.json ~/.local/share/loago/loago.json
cp -f ~/auto/axleizer_invalid.json ~/.local/share/axleizer_invalid.json
git clone https://github.com/Axlefublr/magazine
git clone https://github.com/Axlefublr/music alien_temple
git clone https://github.com/Axlefublr/shows glaza
