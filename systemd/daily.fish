#!/usr/bin/env fish

if test "$(cat ~/fes/zufi/ran-daily)" = (date +%Y.%m.%d)
    return
end
date +%Y.%m.%d >~/fes/zufi/ran-daily

cd ~

while rg -q 8BitDo /proc/bus/input/devices &>/dev/null
    echo 'controller connected; delaying execution' >&2
    sleep 1m
end

fn_clear
trash-empty -f 1
cleaning-lady.nu
kondo -ao 5d -I ~/fes/wks
kondo -o 30d ~/fes/wks

math (cat ~/.local/share/magazine/S) + 67 | sponge ~/.local/share/magazine/S
_magazine_commit ~/.local/share/magazine/S desire

indeed.rs -u ~/fes/nak/semicolon.md -- (propose.rs -n 20% remember 50% ~/.local/share/magazine/s)

truncate -s 0 ~/.local/share/magazine/d

sleep 10 # otherwise, as soon as I wake my pc from sleep, it hasn't connected to the internet at that point, but *has* started executing this script. so what ends up happening is git commands fail to push all the directories because it doesn't have internet to do so yet.

for dir in ~/fes/ork/*
    git -C $dir fetch --all
end

for dir in (cat ~/.local/share/magazine/O)
    cd (string replace -r "^~" "$HOME" $dir)
    autocommit.fish
    git push
end

for dir in (cat ~/.local/share/magazine/P)
    cd (string replace -r "^~" "$HOME" $dir)
    git push
end

foot -T uboot uboot.fish
