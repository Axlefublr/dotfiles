#!/usr/bin/env fish

function anki_sync
    curl localhost:8765 -X POST -d '{ "action": "sync", "version": 6 }'
end
funcsave anki_sync >/dev/null

function anki_add_card
    touch ~/.cache/mine/anki-card.html
    set -l previous_card "$(cat ~/.cache/mine/anki-card.html)"
    neoline_hold ~/.cache/mine/anki-card.html
    if test $previous_card = "$(cat ~/.cache/mine/anki-card.html)"
        return 1
    end
    _magazine_commit ~/.cache/mine/anki-card.html attard
    set -l card (anki-add-card.rs 2>~/.cache/mine/anki-card-errors)
    set -l exitcode $status
    if test -s ~/.cache/mine/anki-card-errors
        notify-send -t 2000 "$(cat ~/.cache/mine/anki-card-errors)"
    end
    test $exitcode -ne 0 && return
    indeed.rs -u ~/.local/share/magazine/A -- "$card"
    _magazine_commit ~/.local/share/magazine/A card
    notify-send -t 3000 "$(tail -n +4 ~/.local/share/magazine/A | wc -l)"
end
funcsave anki_add_card >/dev/null

function anki_import
    curl localhost:8765 -X POST -d '{ "action": "guiImportFile", "version": 6, "params": { "path": "/home/axlefublr/.local/share/magazine/A.txt" } }'
end
funcsave anki_import >/dev/null

function anki_deck -a deck
    curl localhost:8765 -X POST -d '{
        "action": "guiDeckOverview",
        "version": 6,
        "params": {
            "name": "'$deck'"
        }
    }'
end
funcsave anki_deck >/dev/null
