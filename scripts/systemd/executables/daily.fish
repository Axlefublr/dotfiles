#!/usr/bin/env fish

clorange megafon increment

trash-empty -f 1

for file in ~/.local/share/magazine/*
    if not test -s $file
        rm -fr $file
    end
end
cp -fr ~/.local/share/magazine ~/prog/backup
cd ~/prog/backup

set -l changed_magazines (git status -s | rg magazine | wc -l)
if test "$changed_magazines" -gt 0
    git add magazine/
    git commit -m "sync magazine $(date '+%y.%m.%d'): $changed_magazines changes"
    truncate -s 0 ~/.local/share/magazine/d
end

yeared_parse
yearless_parse
daily_parse
task (whensies.py)

if test (math (clorange megafon show) % 30) -eq 0
    task 'megafon (504) tomorrow'
end

if test (date '+%d') -eq 17
    task 'dom.ru (760) tomorrow'
end

if test (date '+%d') -eq 27
    task 'tinkoff premium (200) tomorrow'
end

if test (date '+%A') = Saturday
    task 'new music'
end

if test (date '+%A') = Sunday
    task ask
end

cp -fr ~/.local/share/harp/harp.yml ~/prog/backup/automatic/harp.yml
if git status -s | rg harp.yml
    git add automatic/harp.yml
    git commit -m "sync harp $(date '+%y.%m.%d')"
end

cp -fr ~/.local/share/loago/loago.json ~/prog/backup/automatic/loago.json
if git status -s | rg loago.json
    git add automatic/loago.json
    git commit -m "sync loago $(date '+%y.%m.%d')"
end

cp -fr ~/.local/share/axleizer_invalid.json ~/prog/backup/automatic/axleizer_invalid.json
if git status -s | rg axleizer_invalid.json
    git add automatic/axleizer_invalid.json
    git commit -m "sync axleizer $(date '+%y.%m.%d')"
end

twemoji.fish
loopuntil is_internet 0.5 0 60 # otherwise, as soon as I wake my laptop from sleep, it hasn't connected to wifi at that point, but *has* started executing this script. so what ends up happening is gpp fails to push all the directories because it doesn't have internet to do so yet.

for dir in ~/prog/stored/*
    cd $dir
    git pull
end
gpp
