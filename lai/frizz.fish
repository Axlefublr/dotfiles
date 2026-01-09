#!/usr/bin/env fish

set -f went_off false
for curlie in (tac ~/.local/share/magazine/C)
    set -l bits (string split ' ' $curlie)
    curl $bits[2] --create-dirs -o ~/.local/share/frizz/"$bits[1]"
    if not $went_off
        set -f went_off true
        dot
    end
end
