#!/usr/bin/env fish

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
