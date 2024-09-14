#!/usr/bin/env fish

#----------------------------------------------------anki----------------------------------------------------

function anki-update
    if test (anki-due) -gt 0
        if not test "$argv"
            clorange anki increment
        end
        if test (clorange anki show) -ge 6
            echo due
        end
    else
        clorange anki reset
    end
end
funcsave anki-update >/dev/null

function anki-due
    curl localhost:8765 -X POST -d '{ "action": "findCards", "version": 6, "params": { "query": "is:due" } }' 2>/dev/null | jq .result.[] 2>/dev/null | count
end
funcsave anki-due >/dev/null

function anki-sync
    curl localhost:8765 -X POST -d '{ "action": "sync", "version": 6 }'
end
funcsave anki-sync >/dev/null
