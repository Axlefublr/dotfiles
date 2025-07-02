#!/usr/bin/env fish

mkdir -p ~/wlx \
    ~/iwm \
    ~/iwm/sco \
    ~/iwm/rnt \
    ~/iwm/vdi \
    ~/iwm/lwkc \
    ~/fes \
    ~/fes/ork \
    ~/fes/lai \
    ~/fes/the \
    ~/.local/bin \
    ~/.cache/{mine,wks} \
    ~/.local/share/mine \
    ~/.local/share/{harp,loago}

mkfifo ~/.local/share/mine/waybar-cursor-mode

fish_add_path ~/.local/bin

cd ~
git clone https://github.com/Axlefublr/info ake

cd ~/iwm
git clone https://github.com/Axlefublr/deleted-bangers msk
git clone https://github.com/Axlefublr/pictures-tree osl
git clone https://github.com/Axlefublr/twemoji-svg twemoji
git clone https://github.com/Axlefublr/video-creation-tools tox
git clone https://github.com/Axlefublr/documents dls

cd ~/fes
git clone https://github.com/Axlefublr/autocommit eli
git clone https://github.com/Axlefublr/dotfiles dot
git clone https://github.com/Axlefublr/binaries bin
git clone https://github.com/Axlefublr/backup ack
git clone https://github.com/Axlefublr/job

fish_add_path ~/fes/bin
fish_add_path ~/fes/bin/wks
fish_add_path ~/fes/dot/fish
fish_add_path ~/fes/dot/fish/fun
fish_add_path ~/fes/dot/scripts
fish_add_path ~/fes/dot/scripts/trenchcoat
fish_add_path ~/fes/dot/scripts/scriptister
fish_add_path ~/fes/dot/scripts/fool

cd ~/fes/ork
git clone https://github.com/Axlefublr/helix hx

cd ~/fes/lai
git clone https://github.com/Axlefublr/axlefublr.github.io bog

cd ~/.local/share
cp -f ~/fes/eli/harp.jsonc ~/.local/share/harp/harp.jsonc
cp -f ~/fes/eli/loago.json ~/.local/share/loago/loago.json
cp -f ~/fes/eli/axleizer_invalid.json ~/.local/share/axleizer_invalid.json
git clone https://github.com/Axlefublr/magazine
git clone https://github.com/Axlefublr/music alien_temple
git clone https://github.com/Axlefublr/shows glaza
