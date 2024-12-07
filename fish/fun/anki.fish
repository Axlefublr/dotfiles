#!/usr/bin/env fish

function anki-update
    if test (anki-due-learning) -gt 0
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

function anki-due-learning
    ankuery is:due is:learn
end
funcsave anki-due-learning >/dev/null

function anki-due
    ankuery is:due
end
funcsave anki-due >/dev/null

function anki-once
    ankuery 'deck:Once is:new'
end
funcsave anki-once >/dev/null

function anki-should
    if set -q argv[1]
        anki-should-impl.rb $argv[1]
    else
        anki-should-impl.rb (anki-once)
    end
    # if set -q argv[2]
    #     and set -q argv[3]
    #     set -f freqs (math $argv[2] + $argv[3])
    # else
    #     set -f freqs (ankuery 'deck:Freq is:due')
    # end
    # if test $freqs -le 35
    #     echo freq
    # else
    #     echo dont
    # end
end
funcsave anki-should >/dev/null

function anki-should-test
    for num in (seq 10 10 200)
        echo -n $num' '
        set -l shoulds (anki-should-impl.rb $num)
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

function anki-add-card # TODO: rewrite logic in nim
    neoline_hold ~/bs/anki_card.html
    _magazine_commit ~/bs/anki_card.html attard
    set -l fields (cat ~/bs/anki_card.html)
    test (count $fields) -le 2
    and begin
        notify-send -t 3000 'less than 3 fields'
    end
    test (count $fields) -eq 3 && set fields $fields '' '' ''
    test (count $fields) -eq 4 && set fields $fields '' ''
    test (count $fields) -eq 5 && set fields $fields ''
    indeed -n ~/.local/share/magazine/A -- "$(string join ';' -- $fields)" # FIXME: should wrap fields 3+ in quotes
    _magazine_commit ~/.local/share/magazine/A card
    notify-send -t 5000 "$(tail -n 1 ~/.local/share/magazine/A)"
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
