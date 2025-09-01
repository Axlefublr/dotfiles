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
    ~/.local/bin \
    ~/.cache/{mine,wks} \
    ~/.local/share/mine \
    ~/.local/share/{harp,loago}

echo "d /tmp/mine 0755 $USER $USER -" | sudo tee -a /etc/tmpfiles.d/mine.conf
sudo systemd-tmpfiles --create

fish_add_path ~/.local/bin

cd ~
git clone https://github.com/Axlefublr/info jrl

cd ~/iwm
git clone https://github.com/Axlefublr/deleted-bangers msk
git clone https://github.com/Axlefublr/pictures-tree --depth=1 osl
git clone https://github.com/Axlefublr/twemoji-svg twemoji
git clone https://github.com/Axlefublr/video-creation-tools tox
git clone https://github.com/Axlefublr/documents --depth=1 dls

cd ~/fes
git clone https://github.com/Axlefublr/autocommit jiro
git clone https://github.com/Axlefublr/dotfiles dot
git clone https://github.com/Axlefublr/binaries --depth=1 bin
git clone https://github.com/Axlefublr/backup uviw
git clone https://github.com/Axlefublr/job
git clone https://github.com/Axlefublr/mdw

fish_add_path ~/fes/bin
fish_add_path ~/fes/bin/wks
fish_add_path ~/fes/dot/fish/fun
fish_add_path ~/fes/dot/eli
fish_add_path ~/fes/dot/eli/scriptister
fish_add_path ~/fes/dot/eli/fool
fish_add_path ~/fes/dot/nu/lvoc

cd ~/fes/ork
git clone https://github.com/Axlefublr/helix hx

cd ~/fes/lai
git clone https://github.com/Axlefublr/axlefublr.github.io bog

cd ~/.local/share
cp -f ~/fes/jiro/harp.jsonc ~/.local/share/harp/harp.jsonc
ln -sf ~/fes/jiro/loago.json ~/.local/share/loago/loago.json
cp -f ~/fes/jiro/axleizer_invalid.json ~/.local/share/axleizer_invalid.json
git clone https://github.com/Axlefublr/magazine
git clone https://github.com/Axlefublr/music alien_temple
git clone https://github.com/Axlefublr/shows glaza

ln -sf ~/fes/dot/desktop/aurupdate.desktop ~/.local/share/applications/
ln -sf ~/fes/dot/desktop/wamine.desktop ~/.local/share/applications/
