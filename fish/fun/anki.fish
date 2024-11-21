#!/usr/bin/env fish

function anki-update
    if test (anki-due) -gt 0
        if not test "$argv"
            clorange anki increment >/dev/null
        end
        if test (clorange anki show) -ge 6
            echo due
        end
    else
        clorange anki reset >/dev/null
    end
end
funcsave anki-update >/dev/null

function anki-due
    ankuery is:due is:learn
end
funcsave anki-due >/dev/null

function anki-once
    ankuery 'deck:Once is:new'
end
funcsave anki-once >/dev/null

function anki-should
    anki-should-impl (anki-once)
    shuf -n 1 -e freq dont
end
funcsave anki-should >/dev/null

function anki-should-impl -a onces
    math "round(log2($onces) x 2) - 3"
end
funcsave anki-should-impl >/dev/null

function anki-should-test
    for num in (seq 10 10 200)
        echo -n $num' '
        set -l shoulds (anki-should-impl $num)
        echo -n "$shoulds "
        math "round $num / $shoulds"
    end
end
funcsave anki-should-test >/dev/null

function anki-ram
    ankuery "$(cat ~/.local/share/magazine/G)"
end
funcsave anki-ram >/dev/null

function anki-sync
    curl localhost:8765 -X POST -d '{ "action": "sync", "version": 6 }'
end
funcsave anki-sync >/dev/null

function anki-add-card
    neoline_hold ~/bs/anki_card.html
    set -l fields (cat ~/bs/anki_card.html)
    test (count $fields) -le 2 && return 1
    begin
        test (count $fields) -eq 3 && set fields $fields '' '' ''
        test (count $fields) -eq 4 && set fields $fields '' ''
        test (count $fields) -eq 5 && set fields $fields ''
        indeed -n ~/.local/share/magazine/A "$(string join ';' $fields)"
        _magazine_commit ~/.local/share/magazine/A card
    end
end
funcsave anki-add-card >/dev/null

function anki-import
    curl localhost:8765 -X POST -d '{ "action": "guiImportFile", "version": 6, "params": { "path": "/home/axlefublr/.local/share/magazine/A.txt" } }'
end
funcsave anki-import >/dev/null

function anki-deck -a deck
    curl localhost:8765 -X POST -d '{
        "action": "guiDeckOverview",
        "version": 6,
        "params": {
            "name": "'$deck'"
        }
    }'
end
funcsave anki-deck >/dev/null
