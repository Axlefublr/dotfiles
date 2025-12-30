#!/usr/bin/env fish

while rg -q 8BitDo /proc/bus/input/devices &>/dev/null
    echo 'controller connected; delaying execution' >&2
    sleep 1m
end

trash-empty -f 1
cleaning-lady.nu
# pueue.nu brush

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

cd ~

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
