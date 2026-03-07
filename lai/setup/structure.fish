#!/usr/bin/env fish

mkdir -p ~/wlx \
    ~/iwm \
    ~/iwm/sco \
    ~/iwm/rnt \
    ~/iwm/voe \
    ~/iwm/lwkc \
    ~/fes \
    ~/fes/ork \
    ~/.local/bin \
    ~/.cache/mine \
    ~/.local/share/mine \
    ~/.local/share/{fonts,themes,harp,loago}
fish_add_path ~/.local/bin

echo "d /tmp/mine 0755 $USER $USER -" | sudo tee -a /etc/tmpfiles.d/mine.conf
sudo systemd-tmpfiles --create

cd ~
git clone https://github.com/Axlefublr/ake --depth=1
fish_add_path ~/ake

cd ~/fes
git clone https://github.com/Axlefublr/dotfiles --depth=1 dot
fish_add_path ~/fes/dot/fish/fun
fish_add_path ~/fes/dot/lai
fish_add_path ~/fes/dot/lai/scriptister
fish_add_path ~/fes/dot/lai/fool
fish_add_path ~/fes/dot/nu/lvoc
ln -sf ~/fes/dot/desktop/ ~/.local/share/applications/fesdot

git clone https://github.com/Axlefublr/binaries --depth=1 eva
fish_add_path ~/fes/eva
fish_add_path ~/fes/eva/wks

git clone https://github.com/Axlefublr/autocommit --depth=1 jiro
git clone https://github.com/Axlefublr/backup --depth=1 uviw
git clone https://github.com/Axlefublr/job --depth=1
git clone https://github.com/Axlefublr/mdw --depth=1

cd ~/fes/ork
git clone https://github.com/Axlefublr/hlaix --depth=1 hx
git clone https://github.com/Axlefublr/axlefublr.github.io --depth=1 hirl

cd ~/iwm
git clone https://github.com/Axlefublr/deleted-bangers --depth=1 msk
git clone https://github.com/Axlefublr/pictures-tree --depth=1 osl
git clone https://github.com/Axlefublr/wallpapers --depth=1 kavu
git clone https://github.com/Axlefublr/twemoji-svg --depth=1 twemoji
git clone https://github.com/Axlefublr/video-creation-tools --depth=1 tox
git clone https://github.com/Axlefublr/documents --depth=1 dls

ln -s ~/iwm/dls/fonts ~/.local/share/fonts/mine

cd ~/.local/share
ln -sf ~/fes/jiro/harp.jsonc ~/.local/share/harp/harp.jsonc
ln -sf ~/fes/jiro/axleizer_invalid.json ~/.local/share/axleizer_invalid.json
ln -sf ~/fes/jiro/loago.json ~/.local/share/loago/loago.json
git clone https://github.com/Axlefublr/magazine --depth=1
git clone https://github.com/Axlefublr/music alien_temple --depth=1
git clone https://github.com/Axlefublr/shows glaza --depth=1
