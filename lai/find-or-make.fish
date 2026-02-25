#!/usr/bin/env fish

set -l wheres
for arg in $argv[..-2]
    set -a wheres "| where $arg"
end
na -c "niri msg -j windows
    | from json
    $wheres
    | get id
    | first
    | try {
        niri msg action focus-window --id \$in
    } catch {
        niri msg action spawn -- $argv[-1]
}"
