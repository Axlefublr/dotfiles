#!/usr/bin/env fish

for line in (cat ~/.local/share/magazine/v)
    set -l match (string match -gr '(\\d+).(\\d+.\\d+) — (.*)' $line)
    set -l year $match[1]
    set -l date $match[2]
    set -l description $match[3]
    if not test $date = (date +%m.%d)
        continue
    end
    set year (math (date +%y) - $year)
    task "$year years ago: $description"
end
