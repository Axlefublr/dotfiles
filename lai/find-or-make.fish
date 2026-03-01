#!/usr/bin/env fish

set -l wheres
for arg in $argv[..-2]
    set -a wheres "| where $arg"
end
na -c "
    let found = niri msg -j windows
    | from json
    $wheres
    if (\$found | is-not-empty) {
    	if (\$found | any { get is_focused }) {
    		niri msg action focus-window-previous
    	} else {
    		\$found | first | each { niri msg action focus-window --id (\$in | get id) }
    	}
    } else {
        niri msg action spawn -- $argv[-1]
    }
"
