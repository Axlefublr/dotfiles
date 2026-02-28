#!/usr/bin/env -S nu --no-std-lib -n

let toggleterm = niri msg -j windows
| from json
| where app_id != null
| where app_id starts-with 'foot'
| where title == 'toggleterm'
if ($toggleterm | is-not-empty) {
	if ($toggleterm | any { get is_focused }) {
		niri msg action focus-window-previous
	} else {
		$toggleterm | first | each { niri msg action focus-window --id ($in | get id) }
	}
} else {
	niri msg action spawn -- footclient -NT toggleterm
}
