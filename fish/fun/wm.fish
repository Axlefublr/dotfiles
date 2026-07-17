#!/usr/bin/env fish

function wm_focus_if_exists
    set -l wheres
    for arg in $argv
        set -a wheres "| where $arg"
    end
    na -c "
        let found = niri msg -j windows
        | from json
        $wheres
        if (\$found | is-not-empty) {
            niri msg action focus-window --id (\$found | get id | first)
        } else {
            exit 1
        }
    "
end
funcsave wm_focus_if_exists >/dev/null

function wm_wait_if_or_until_exists
    set -l wheres
    for arg in $argv
        set -a wheres "| where $arg"
    end
    na -c "
    for line in (niri msg -j event-stream | lines) {
        let object = \$line | from json --objects
        \$object | try {
            get WindowsChanged.windows.0
            $wheres
            | if (\$in | is-not-empty) {
                exit
            }
        }
        \$object | try {
            get WindowOpenedOrChanged.window
            $wheres
            | if (\$in | is-not-empty) {
                exit
            }
        }
    }
    "
end
funcsave wm_wait_if_or_until_exists >/dev/null
