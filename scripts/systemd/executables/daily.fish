#!/usr/bin/env fish

clorange megafon increment

trash-empty -f 2

cd ~/.local/share/magazine
git add .
and git commit -m leftovers
truncate -s 0 ~/.local/share/magazine/d

# these make tasks, and should go after the magazine autocommit to get added onto a clean slate
yeared_parse
yearless_parse
task (whensies.py)
clorange habit increment
set even (test (math (clorange habit show) % 2) -eq 0)
if test $even
    begin
        echo magazine D
        echo anki
        echo exercise
        echo shower
    end >~/.local/share/magazine/x
else
    begin
        echo shave
        echo anki
        echo commits
        echo exercise
        echo head
    end >~/.local/share/magazine/x
end

if test (math (clorange megafon show) % 30) -eq 0
    task 'megafon (579) tomorrow'
end

if test (date '+%d') -eq 17
    task 'dom.ru (760) tomorrow'
end

if test (date '+%d') -eq 19
    task 'tinkoff subscription (299) tomorrow'
end

if test (date '+%A') = Sunday
    task ask
end

cd ~/prog/autocommit

cp -fr ~/.local/share/harp/harp.yml ~/prog/autocommit/harp.yml
git add harp.yml
and git commit -m "sync harp"

cp -fr ~/.local/share/loago/loago.json ~/prog/autocommit/loago.json
git add loago.json
and git commit -m "sync loago"

cp -fr ~/.local/share/axleizer_invalid.json ~/prog/autocommit/axleizer_invalid.json
git add axleizer_invalid.json
and git commit -m "sync axleizer"

set -l autocommitted ~/pic/twemoji-svg ~/pic/tree ~/pic/tools ~/prog/binaries
for dir in $autocommitted
    cd $dir
    autocommit
end

loopuntil is_internet 0.5 0 60 # otherwise, as soon as I wake my laptop from sleep, it hasn't connected to wifi at that point, but *has* started executing this script. so what ends up happening is gpp fails to push all the directories because it doesn't have internet to do so yet.

for dir in ~/prog/forks/*
    cd $dir
    git fetch
end

for dir in ~/prog/stored/*
    cd $dir
    git fetch
    git reset --hard origin/(git branch --show-current)
end

for dir in (cat ~/.local/share/magazine/R)
    set dir (string replace -r "^~" "$HOME" $dir)
    cd $dir
    git push
end
