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
    | sort-by title
    | sort-by { get title | str length } # -r helps you focus on more specific window first, lack of -r helps you focus on the more broad window first
    if (\$found | is-not-empty) {
        let focused_togglie = \$found | where is_focused == true | first | get -o id
    	if (\$focused_togglie | is-not-empty) {
        	# if on $found length here
       	if (\$found | length | \$in > 1) {
        	    let next = \$found | get -o id | skip while { |it| \$it != \$focused_togglie } | skip 1 | first
        	    if (\$next | is-empty) {
              		\$found | first | each {
              		    niri msg action focus-window --id (\$in | get id)
              		    niri msg action center-visible-columns
              		}
        	    } else {
          		    niri msg action focus-window --id \$next
          		    niri msg action center-visible-columns
        	    }
        	} else {
          		niri msg action focus-window-previous
        	}
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
