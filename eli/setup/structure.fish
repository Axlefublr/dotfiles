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
fish_add_path ~/.local/bin

echo "d /tmp/mine 0755 $USER $USER -" | sudo tee -a /etc/tmpfiles.d/mine.conf
sudo systemd-tmpfiles --create

cd ~
git clone https://github.com/Axlefublr/info --depth=1 jrl

cd ~/fes
git clone https://github.com/Axlefublr/dotfiles --depth=1 dot
fish_add_path ~/fes/dot/fish/fun
fish_add_path ~/fes/dot/eli
fish_add_path ~/fes/dot/eli/scriptister
fish_add_path ~/fes/dot/eli/fool
fish_add_path ~/fes/dot/nu/lvoc

git clone https://github.com/Axlefublr/binaries --depth=1 bin
fish_add_path ~/fes/bin
fish_add_path ~/fes/bin/wks

git clone https://github.com/Axlefublr/autocommit --depth=1 jiro
git clone https://github.com/Axlefublr/backup --depth=1 uviw
git clone https://github.com/Axlefublr/job --depth=1
git clone https://github.com/Axlefublr/mdw --depth=1

cd ~/fes/ork
git clone https://github.com/Axlefublr/helix --depth=1 hx

cd ~/fes/lai
git clone https://github.com/Axlefublr/axlefublr.github.io --depth=1 bog

cd ~/iwm
git clone https://github.com/Axlefublr/deleted-bangers --depth=1 msk
git clone https://github.com/Axlefublr/pictures-tree --depth=1 osl
git clone https://github.com/Axlefublr/twemoji-svg --depth=1 twemoji
git clone https://github.com/Axlefublr/video-creation-tools --depth=1 tox
git clone https://github.com/Axlefublr/documents --depth=1 dls

cd ~/.local/share
cp -f ~/fes/jiro/harp.jsonc ~/.local/share/harp/harp.jsonc
ln -sf ~/fes/jiro/loago.json ~/.local/share/loago/loago.json
cp -f ~/fes/jiro/axleizer_invalid.json ~/.local/share/axleizer_invalid.json
git clone https://github.com/Axlefublr/magazine --depth=1
git clone https://github.com/Axlefublr/music alien_temple --depth=1
git clone https://github.com/Axlefublr/shows glaza --depth=1

ln -sf ~/fes/dot/desktop/aurupdate.desktop ~/.local/share/applications/
ln -sf ~/fes/dot/desktop/wamine.desktop ~/.local/share/applications/
