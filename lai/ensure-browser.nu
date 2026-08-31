#!/usr/bin/env -S nu --no-std-lib -n

let foxes = niri msg -j windows
| from json
| where app_id == firefox
# xdg-open and the like opens the link in whichever browser was active the most recently
| sort-by -r focus_timestamp.secs focus_timestamp.nanos
$foxes
| any is_focused == true
| if $in { exit }
$foxes
| where is_focused == false
| get id
| try { first }
| each {
	niri msg action focus-window --id $in
} | ignore
