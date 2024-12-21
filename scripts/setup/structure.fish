#!/usr/bin/env fish

cd ~
mkdir -p ups pic vid prog bs t trans
git clone https://github.com/Axlefublr/deleted-bangers
mv deleted-bangers mus
git clone https://github.com/Axlefublr/autocommit
mv autocommit auto

cd ~/pic
git clone https://github.com/Axlefublr/pictures-tree
mv pictures-tree tree
git clone https://github.com/Axlefublr/twemoji-svg
git clone https://github.com/Axlefublr/video-creation-tools
mv video-creation-tools tools

cd ~/prog
mkdir -p forks proj stored the
git clone https://github.com/Axlefublr/dotfiles
git clone https://github.com/Axlefublr/binaries
git clone https://github.com/Axlefublr/backup
git clone https://github.com/Axlefublr/info
git clone https://github.com/Axlefublr/job

cd ~/prog/forks
git clone https://github.com/Axlefublr/helix

cd ~/.local/share
mkdir -p harp loago
cp -f ~/auto/harp.yml ~/.local/share/harp/harp.yml
cp -f ~/auto/loago.json ~/.local/share/loago/loago.json
cp -f ~/auto/axleizer_invalid.json ~/.local/share/axleizer_invalid.json
git clone https://github.com/Axlefublr/magazine
git clone https://github.com/Axlefublr/music
mv music alien_temple
git clone https://github.com/Axlefublr/shows
mv shows glaza
