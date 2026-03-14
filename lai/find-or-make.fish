#!/usr/bin/env fish

argparse clean -- $argv
set -l wheres
for arg in $argv[..-2]
    set -a wheres "| where $arg"
end
na -c "
    let found = niri msg -j windows
    | from json
    $wheres
    if (\$found | is-not-empty) {
        let focused_togglie = \$found | where is_focused == true | first | get -o id
    	if (\$focused_togglie | is-not-empty) {
    		niri msg action focus-window-previous
        	if ('$_flag_clean' == '--clean') {
            	niri msg action close-window --id \$focused_togglie
        	}
    	} else {
    		\$found | first | each {
    		    niri msg action focus-window --id (\$in | get id)
    		    niri msg action center-visible-columns
    		}
    	}
    } else {
        niri msg action spawn -- $argv[-1]
    }
"
