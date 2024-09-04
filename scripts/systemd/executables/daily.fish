#!/usr/bin/env fish

clorange megafon increment

trash-empty -f 1

cd ~/.local/share/magazine
git add .
and git commit -m leftovers
truncate -s 0 ~/.local/share/magazine/d

yeared_parse
yearless_parse
daily_parse
task (whensies.py)

if test (math (clorange megafon show) % 30) -eq 0
    task 'megafon (579) tomorrow'
end

if test (date '+%d') -eq 17
    task 'dom.ru (760) tomorrow'
end

if test (date '+%d') -eq 27
    task 'tinkoff premium (200) tomorrow'
end

if test (date '+%A') = Sunday
    task ask
end

cd ~/prog/backup

cp -fr ~/.local/share/harp/harp.yml ~/prog/backup/automatic/harp.yml
git add automatic/harp.yml
and git commit -m "sync harp"

cp -fr ~/.local/share/loago/loago.json ~/prog/backup/automatic/loago.json
git add automatic/loago.json
and git commit -m "sync loago"

cp -fr ~/.local/share/axleizer_invalid.json ~/prog/backup/automatic/axleizer_invalid.json
git add automatic/axleizer_invalid.json
and git commit -m "sync axleizer"

twemoji.fish
loopuntil is_internet 0.5 0 60 # otherwise, as soon as I wake my laptop from sleep, it hasn't connected to wifi at that point, but *has* started executing this script. so what ends up happening is gpp fails to push all the directories because it doesn't have internet to do so yet.

for dir in ~/prog/stored/*
    cd $dir
    git pull
end

gpp
