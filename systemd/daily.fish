#!/usr/bin/env fish

trash-empty -f 1

cd ~/.local/share/magazine
for file in ~/.local/share/magazine/*
    _magazine_commit $file left
end
git add .
and git commit -m leftovers
truncate -s 0 ~/.local/share/magazine/d

# these make tasks, and should go after the magazine autocommit to get added onto a clean slate
yeared_parse
indeed.rs ~/.local/share/magazine/x (cat ~/.local/share/magazine/leftbrace)
indeed.rs -u ~/.local/share/magazine/semicolon -- (propose.rs remember 50% ~/.local/share/magazine/s)

cd ~/auto

cp -fr ~/.local/share/harp/harp.yml ~/auto/harp.yml
git add harp.yml
and git commit -m 'sync harp'

cp -fr ~/.local/share/loago/loago.json ~/auto/loago.json
git add loago.json
and git commit -m 'sync loago'

cp -fr ~/.local/share/axleizer_invalid.json ~/auto/axleizer_invalid.json
git add axleizer_invalid.json
and git commit -m 'sync axleizer'

cp -fr ~/.config/calcure/events.csv ~/auto/calcure.csv
git add calcure.csv
and git commit -m 'sync calcure'

cp -fr ~/.config/nom/nom.db ~/auto/nom.db
git add nom.db
and git commit -m 'sync nom'

cp -fr ~/.local/share/zoxide/db.zo ~/auto/zoxide.db
git add zoxide.db
and git commit -m 'sync zoxide'

set -l autocommitted ~/i/twemoji-svg ~/i/e ~/i/tools ~/r/binaries ~/r/backup
for dir in $autocommitted
    cd $dir
    autocommit
end

sleep 10 # otherwise, as soon as I wake my pc from sleep, it hasn't connected to the internet at that point, but *has* started executing this script. so what ends up happening is git commands fail to push all the directories because it doesn't have internet to do so yet.

nom refresh

for dir in ~/r/forks/*
    git -C $dir fetch
    git -C $dir fetch upstream
end

for dir in ~/r/stored/*
    git -C $dir fetch
    git -C $dir reset --hard origin/HEAD
end

for dir in (cat ~/.local/share/magazine/R)
    git -C (string replace -r "^~" "$HOME" $dir) push
end

footclient -NT uboot calcure
footclient -NHT uboot fish -c fm
footclient -NT uboot helix ~/.local/share/magazine/semicolon

ubootf
