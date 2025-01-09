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

function anki-add-card
    set -l previous_card "$(cat ~/bs/anki-card.html)"
    neoline-hold ~/bs/anki-card.html
    if test $previous_card = "$(cat ~/bs/anki-card.html)"
        return 1
    end
    _magazine_commit ~/bs/anki-card.html attard
    set -l card (anki-add-card.rs 2>~/bs/anki-card-errors)
    set -l exitcode $status
    if test -s ~/bs/anki-card-errors
        notify-send -t 2000 "$(cat ~/bs/anki-card-errors)"
    end
    test $exitcode -ne 0 && return
    indeed -nu ~/.local/share/magazine/A -- "$card"
    _magazine_commit ~/.local/share/magazine/A card
    notify-send -t 3000 "$(tail -n +4 ~/.local/share/magazine/A | wc -l)"
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
