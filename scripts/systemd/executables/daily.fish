#!/usr/bin/env fish

clorange megafon increment

trash-empty -f 1

cd ~/.local/share/magazine
git add .
and git commit -m leftovers
truncate -s 0 ~/.local/share/magazine/d

# these make tasks, and should go after the magazine autocommit to get added onto a clean slate
yeared_parse
yearless_parse
task (whensies.py)

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

set -l autocommitted ~/pic/twemoji-svg ~/pic/tree ~/pic/tools
for dir in $autocommitted
    cd $dir
    autocommit
end

loopuntil is_internet 0.5 0 60 # otherwise, as soon as I wake my laptop from sleep, it hasn't connected to wifi at that point, but *has* started executing this script. so what ends up happening is gpp fails to push all the directories because it doesn't have internet to do so yet.

for dir in ~/prog/stored/*
    cd $dir
    git pull
end

for dir in (cat ~/.local/share/magazine/R)
    set dir (string replace -r "^~" "$HOME" $dir)
    cd $dir
    git push
end

for dir in ~/prog/forks/*
    cd $dir
    git fetch upstream
end
