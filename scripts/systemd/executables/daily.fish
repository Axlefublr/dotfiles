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
yearless_parse
task (whensies.py)
if test (math (clorange habit increment) % 2) -eq 0
    indeed -n ~/.local/share/magazine/x (cat ~/.local/share/magazine/leftbrace)
else
    indeed -n ~/.local/share/magazine/x (cat ~/.local/share/magazine/rightbrace)
end

if test (math (clorange megafon increment) % 30) -eq 0
    task 'megafon (579) tomorrow'
end

if test (date '+%A') = Monday
    task ask
end

awesome-client 'Registers_wu()'

cd ~/auto

cp -fr ~/.local/share/harp/harp.yml ~/auto/harp.yml
git add harp.yml
and git commit -m "sync harp"

cp -fr ~/.local/share/loago/loago.json ~/auto/loago.json
git add loago.json
and git commit -m "sync loago"

cp -fr ~/.local/share/axleizer_invalid.json ~/auto/axleizer_invalid.json
git add axleizer_invalid.json
and git commit -m "sync axleizer"

cp -fr ~/.config/nom/nom.db ~/auto/nom.db
git add nom.db
and git commit -m "sync nom"

set -l autocommitted ~/pic/twemoji-svg ~/pic/tree ~/pic/tools ~/prog/binaries
for dir in $autocommitted
    cd $dir
    autocommit
end

loopuntil is_internet 0.5 0 60 # otherwise, as soon as I wake my laptop from sleep, it hasn't connected to wifi at that point, but *has* started executing this script. so what ends up happening is gpp fails to push all the directories because it doesn't have internet to do so yet.

for dir in ~/prog/forks/*
    git -C $dir fetch
    git -C $dir fetch upstream
end

for dir in ~/prog/stored/*
    git -C $dir fetch
    git -C $dir reset --hard origin/HEAD
end

for dir in (cat ~/.local/share/magazine/R)
    git -C (string replace -r "^~" "$HOME" $dir) push
end

indeed -nu ~/.local/share/magazine/semicolon -- (shuf -n 1 ~/.local/share/magazine/s)

ubootf
