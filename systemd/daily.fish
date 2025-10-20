#!/usr/bin/env fish

while rg -q 8BitDo /proc/bus/input/devices &>/dev/null
    echo 'controller connected; delaying execution' >&2
    sleep 1m
end

trash-empty -f 1
cleaning-lady.nu
pueue.nu brush

# not using the normal autocommit functionality because we want to execute on-magazine-commit actions, like uniquing and sorting
cd ~/.local/share/magazine
for file in ~/.local/share/magazine/*
    _magazine_commit $file left
    # crucially, this happens to do `frizz`, and is the only reason we don't do it explicitly in uboot
end
git add .
and git commit -m leftovers
truncate -s 0 ~/.local/share/magazine/d

# these make tasks, and should go after the magazine autocommit to get added onto a clean slate
yeared_parse
indeed.rs -u ~/.local/share/magazine/semicolon -- (propose.rs -n 20% remember 50% ~/.local/share/magazine/s)

cd ~/fes/jiro

cp -fr ~/.local/share/harp/harp.jsonc ~/fes/jiro/harp.jsonc
git add harp.yml
and git commit -m 'sync harp'

git add loago.json
and git commit -m 'sync loago'

cp -fr ~/.local/share/axleizer_invalid.json ~/fes/jiro/axleizer_invalid.json
git add axleizer_invalid.json
and git commit -m 'sync axleizer'

cp -fr ~/.config/calcure/events.csv ~/fes/jiro/calcure.csv
git add calcure.csv
and git commit -m 'sync calcure'

cp -fr ~/.config/nom/nom.db ~/fes/jiro/nom.db
git add nom.db
and git commit -m 'sync nom'

cp -fr ~/.local/share/zoxide/db.zo ~/fes/jiro/zoxide.db
git add zoxide.db
and git commit -m 'sync zoxide'

rsync (recent-modified.nu ~/wlx/tabs) ~/fes/jiro/browser-tabs.json
git add browser-tabs.json
and git commit -m 'sync tabs'

sleep 10 # otherwise, as soon as I wake my pc from sleep, it hasn't connected to the internet at that point, but *has* started executing this script. so what ends up happening is git commands fail to push all the directories because it doesn't have internet to do so yet.

for dir in ~/fes/ork/*
    git -C $dir fetch --all
end

for dir in (cat ~/.local/share/magazine/O)
    cd (string replace -r "^~" "$HOME" $dir)
    autocommit
    git push
end

for dir in (cat ~/.local/share/magazine/P)
    cd (string replace -r "^~" "$HOME" $dir)
    git push
end

things
ubootf
