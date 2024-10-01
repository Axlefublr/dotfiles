#!/usr/bin/env fish

#------------------------------------------------------------------------------------------------------------
#          for special logic and "functionality", often app-specific or in other ways hyperspecific          
#------------------------------------------------------------------------------------------------------------

#----------------------------------------------------anki----------------------------------------------------

function anki_update
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
funcsave anki_update >/dev/null

function anki-due
    curl localhost:8765 -X POST -d '{ "action": "findCards", "version": 6, "params": { "query": "is:due" } }' 2>/dev/null | jq .result.[] 2>/dev/null | count
end
funcsave anki-due >/dev/null

function anki-sync
    curl localhost:8765 -X POST -d '{ "action": "sync", "version": 6 }'
end
funcsave anki-sync >/dev/null

#--------------------------------------------------terminal--------------------------------------------------

function set_tab_title
    read -P 'title: ' new_title
    if not test "$new_title"
        kitten @ set-tab-title ""
        return
    end
    kitten @ set-tab-title " $new_title"
end
funcsave set_tab_title >/dev/null

#---------------------------------------------------helix---------------------------------------------------

function execute_somehow -d 'expects cwd, then full path to the buffer as args'
    if not test "$argv[2]"
        return
    end
    set -l extension (path extension $argv[2] | cut -c 2-)
    switch $extension
        case py
            python $argv[2]
        case fish
            fish $argv[2]
    end
end
funcsave execute_somehow >/dev/null
